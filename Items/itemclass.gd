class_name Item extends Area2D
var explImmume : bool = false
func gracePeriod() -> void:
	Global.secure_await_phy_frame(4)
	explImmume = false

func defaultMeta() -> void:
	set_meta("Item", false)
