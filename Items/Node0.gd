extends Area2D

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	Global.player_speed_mod += 1
	Global.player_speed_scaling += 5
	queue_free()
	
@warning_ignore("unused_parameter")
func _process(delta):
	if global_position.y - Global.player_pos_y > 888:
		queue_free()