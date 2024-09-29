extends Control

func _ready():
	await get_tree().create_timer(2).timeout
	queue_free()
