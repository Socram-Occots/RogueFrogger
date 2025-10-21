extends Control


#@onready paused = false
@onready var seedy: Label = $CenterContainer/ColorRect/VBoxContainer/Seed
@onready var score: Label = $CenterContainer/ColorRect/VBoxContainer/Score
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	pass

func show_seed() -> void:
	seedy.set_text("Seed: " + str(GRand.maprand.get_seed()))

func _on_visibility_changed():
	if visible:
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

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if visible:
			Global.unpause()
		elif !visible:
			Global.pause()
