extends Control

@onready var game_over: Label = $"CenterContainer/ColorRect/VBoxContainer/game over"
@onready var score: Label = $CenterContainer/ColorRect/VBoxContainer/Score
@onready var seedy: Label = $CenterContainer/ColorRect/VBoxContainer/Seed
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sandbox_seed : String = SettingsDataContainer.get_sandbox_seed(!Global.sandbox)
@onready var retry: Button = $CenterContainer/ColorRect/VBoxContainer/HBoxContainer/retry

func _ready():
	add_to_group("UI_FOCUS", true)

func begin_focus() -> void:
	if visible:
		retry.grab_focus.call_deferred()

func show_seed() -> void:
	if Global.sandbox && sandbox_seed:
		seedy.set_text("Seed: " + sandbox_seed)
	else:
		seedy.set_text("Seed: " + str(GRand.maprand.get_seed()))

func _on_visibility_changed():
	if visible:
		if !Global.sandbox && Global.score > SettingsDataContainer.get_high_score():
			SettingsSignalBus.emit_on_high_score_set(Global.score)
			SettingsSignalBus.emit_set_settings_dictionary(SettingsDataContainer.create_storage_dictionary())
		elif Global.challenge && \
		Global.score > SettingsDataContainer.get_challenges_high_score(Global.challenge_curr):
			SettingsSignalBus.emit_on_challenges_high_score_set(Global.challenge_curr, Global.score)
			SettingsSignalBus.emit_set_settings_dictionary(SettingsDataContainer.create_storage_dictionary())
		score.text = "Score: " + str(Global.score)
		animation_player.play("startpause")
		show_seed()
		begin_focus()

func _on_retry_pressed():
	Global.reset()
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_menu_pressed():
	Global.reset()
	get_tree().paused = false
	Global.back_to_startscreen = true
	get_tree().change_scene_to_file("res://menus/startscreen.tscn")

func _on_quit_pressed():
	get_tree().quit()
