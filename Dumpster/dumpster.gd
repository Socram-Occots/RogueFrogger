extends StaticElement
@onready var rectangle: Rectangle = $Rectangle

func _ready() -> void:
	rectangle.visible = SettingsDataContainer.get_show_hitboxes()
	rectangle.size.y = 52
	set_meta("Dumpster", true)

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	if !SettingsDataContainer.get_logbook_dict("Objects", "Dumpster")[0]:
		SettingsSignalBus.emit_on_logbook_dict_set("Objects", "Dumpster", true, 0)
