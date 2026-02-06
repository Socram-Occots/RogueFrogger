extends Control

@onready var game_over: Label = $"CenterContainer/ColorRect/VBoxContainer/game over"
@onready var score: Label = $CenterContainer/ColorRect/VBoxContainer/Score
@onready var seedy: Label = $CenterContainer/ColorRect/VBoxContainer/Seed
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sandbox_seed : String = SettingsDataContainer.get_sandbox_seed(!Global.sandbox)
@onready var retry: Button = $CenterContainer/ColorRect/VBoxContainer/HBoxContainer/retry
@onready var deathreviewtexture_rect: TextureRect = $DeathReview/TextureRect
@onready var deathreviewlabel: Label = $DeathReview/HBoxContainer/Label

var deathcause : String = "Uknown"

func _ready():
	add_to_group("UI_FOCUS", true)

func set_death_review() -> void:
	deathreviewlabel.text = "Your run was ended by: " + Global.convert_keyword_to_title(deathcause) 
	deathreviewtexture_rect.texture = Global.get_texture_icons(deathcause, "Death Review")

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
		score.text = "Score: " + str(Global.score)
		animation_player.play("startpause")
		show_seed()
		set_death_review()
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
