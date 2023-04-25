extends Area2D

@onready var activated = false

@warning_ignore("unused_parameter")
func _process(delta):
	if position.y - Global.player_pos_y > 540:
		position.y = Global.player_pos_y + 540
		activated = true
	if activated:	
		position.y -= 0.1

func _on_body_entered(body):
	get_tree().change_scene_to_file("res://GameUI/game_ui.tscn")
