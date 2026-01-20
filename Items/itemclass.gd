class_name Item extends Area2D

func _ready() -> void:
	set_meta("Item", false)
	# grace period for item incase it spawned in an explosion
	for i in range(0, 7):
		await get_tree().physics_frame
