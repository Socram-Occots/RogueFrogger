extends Area2D

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	Global.dash = true
	Global.dash_mod += 1
	Global.dash_scaling += 0.03
	var adjustment = Global.dash_scaling/Global.dash_base
	Global.dash_time = Global.dash_base_time/adjustment
	Global.dash_cool_down /= 1.01
	queue_free()

@warning_ignore("unused_parameter")
func _process(delta):
	if global_position.y - Global.player_pos_y > 888:
		queue_free()
