extends Area2D

@onready var activated = false

@warning_ignore("unused_parameter")
func _process(delta):
	if position.y - Global.player_pos_y > 425:
		position.y = Global.player_pos_y + 425
		activated = true
	if activated:
		position.y -= 20 * delta

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	var metalist = body.get_meta_list()
	if "Player" in metalist:
#		print("line")
		get_tree().change_scene_to_file("res://GameUI/game_ui.tscn")
