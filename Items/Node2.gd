extends Area2D

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	var metalist = body.get_meta_list()
	if "Player" in metalist:
		Global.car_speed_mod += 1
		Global.car_speed_scaling -= 4
		if Global.car_speed_scaling < 100:
			Global.car_speed_scaling = 100
		queue_free()

@warning_ignore("unused_parameter")
func _process(delta):
	if global_position.y - Global.player_pos_y > 888:
		queue_free()
