class_name Item extends Area2D
var explImmume : bool = false
func gracePeriod() -> void:
	for i in range(0, 4):
		await get_tree().physics_frame
	explImmume = false

func defaultMeta() -> void:
	set_meta("Item", false)
