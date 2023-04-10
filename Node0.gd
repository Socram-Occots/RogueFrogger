extends Area2D

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	Global.player_speed_mod += 1
	Global.player_speed_scaling = 70*(log(Global.player_speed_mod) / log(5)) + Global.player_base_speed
	queue_free()
