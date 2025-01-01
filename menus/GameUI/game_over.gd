extends Control


func _ready():
	pass

func _on_visibility_changed():
	if visible:
		$CenterContainer/ColorRect/VBoxContainer/Score.text = "Score: " + str(Global.score)
		$AnimationPlayer.play("startpause")

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
