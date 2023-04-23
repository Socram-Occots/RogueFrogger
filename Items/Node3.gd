extends Area2D

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	Global.dash = true
	Global.dash_mod += 1
	Global.dash_scaling = (Global.car_speed_mod-1)*0.03 + Global.dash_base
	var adjustment = Global.dash_scaling/Global.dash_base
	Global.dash_time = Global.dash_base_time/adjustment
	Global.dash_cool_down = Global.dash_cool_down_base/1.01
	queue_free()

@warning_ignore("unused_parameter")
func _process(delta):
	if global_position.y - Global.player_pos_y > 777:
		queue_free()
