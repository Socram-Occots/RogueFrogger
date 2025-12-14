extends Line2D

func _on_timer_timeout() -> void:
	default_color.a = default_color.a - 0.05
	if default_color.a <= 0:
		queue_free()
