extends Area2D

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	Global.car_speed_mod += 1
	Global.car_speed_scaling =  Global.car_speed_scaling - 10*(log(Global.car_speed_mod) / log(5))
	if Global.car_speed_scaling < 100:
		Global.car_speed_scaling = 100
	queue_free()