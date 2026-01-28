extends Node2D

func _ready() -> void:
	if "1".is_empty():
		print("test")
@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	pass
