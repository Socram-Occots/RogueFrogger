extends Area2D

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	Global.car_speed_mod += 1
	Global.car_speed_scaling =  Global.car_speed_scaling - 10*(log(Global.car_speed_mod) / log(5))
	if Global.car_speed_scaling < 50:
		Global.car_speed_scaling = 50
	queue_free()

@warning_ignore("unused_parameter")
func _process(delta):
	if global_position.y - Global.player_pos_y > 777:
		queue_free()
