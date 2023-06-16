extends Area2D

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	var metalist = body.get_meta_list()
	if "Player" in metalist:
		Global.timer_mod += 1
		Global.timer_l += 0.01
		Global.timer_h += 0.01
		queue_free()

@warning_ignore("unused_parameter")
func _process(delta):
	if global_position.y - Global.player_pos_y > 888:
		queue_free()
