extends Control


#@onready paused = false
@onready var seedy: Label = $CenterContainer/ColorRect/VBoxContainer/Seed
@onready var score: Label = $CenterContainer/ColorRect/VBoxContainer/Score
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
	get_tree().change_scene_to_file("res://menus/startscreen.tscn")
	
func _on_quit_pressed():
	get_tree().quit()

func _on_resume_pressed() -> void:
	if visible:
		Global.unpause()

func _input(event):
	if event.is_action_pressed("ui_pause"):
		if visible:
			Global.unpause()
		elif !visible:
			Global.pause()
