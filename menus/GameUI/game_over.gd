extends Control

@onready var game_over: Label = $"CenterContainer/ColorRect/VBoxContainer/game over"
@onready var score: Label = $CenterContainer/ColorRect/VBoxContainer/Score
@onready var seedy: Label = $CenterContainer/ColorRect/VBoxContainer/Seed
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sandbox_seed : String = SettingsDataContainer.get_sandbox_seed(!Global.sandbox)

func _ready():
	pass

func show_seed() -> void:
	if Global.sandbox && sandbox_seed:
		seedy.set_text("Seed: " + sandbox_seed)
	else:
		seedy.set_text("Seed: " + str(GRand.maprand.get_seed()))

func _on_visibility_changed():
	if visible:
		if Global.score > SettingsDataContainer.get_high_score():
			SettingsSignalBus.emit_on_high_score_set(Global.score)
			SettingsSignalBus.emit_set_settings_dictionary(SettingsDataContainer.create_storage_dictionary())
		score.text = "Score: " + str(Global.score)
		animation_player.play("startpause")
		show_seed()

func _on_retry_pressed():
	Global.reset()
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_menu_pressed():
	Global.reset()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menus/startscreen.tscn")

func _on_quit_pressed():
	get_tree().quit()
