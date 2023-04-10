extends Area2D

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	Global.timer_mod += 1
	Global.timer_scaling = 0.05*(log(Global.timer_mod) / log(20)) + Global.timer_base
	Global.timer_l *= Global.timer_scaling
	Global.timer_h *= Global.timer_scaling
	queue_free()
