extends StaticBody2D
@onready var polygon_2d: Polygon2D = $CollisionShape2D/Polygon2D

func _ready() -> void:
	pass
	
@warning_ignore("unused_parameter")
func _physics_process(delta):
	pass

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	if !SettingsDataContainer.get_logbook_dict("Objects", "Barrel")[0]:
		SettingsSignalBus.emit_on_logbook_dict_set("Objects", "Barrel", true, 0)
