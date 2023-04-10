extends Control

func _ready():
	$Score.text = "Score: " + str(Global.score)

@warning_ignore("unused_parameter")
func _process(delta):
	if Input.is_action_pressed("start_game"):
		Global.reset()
		get_tree().change_scene_to_file("res://Level/level.tscn")
