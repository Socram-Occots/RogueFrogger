extends Area2D

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	Global.variation += 1
	Global.variation_scaling = 0.01*(log(Global.variation) / log(20)) + Global.variation_base
	Global.timer_l /= Global.variation_scaling
	Global.timer_h *= Global.variation_scaling
	queue_free()
