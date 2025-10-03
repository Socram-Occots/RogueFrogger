extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print(body)
	body.queue_free()

func _on_area_entered(area: Area2D) -> void:
	print(area)
	area.queue_free()
