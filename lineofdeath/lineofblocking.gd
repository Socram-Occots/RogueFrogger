extends StaticBody2D

@warning_ignore("unused_parameter")
func _physics_process(delta):
	if position.y - Global.player_pos_y > 550:
		position.y = Global.player_pos_y + 550
