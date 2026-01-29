extends OptionButton

@export var group : String

func _ready():
	add_to_group(group)
	GlobalAccesibilitySignal.color_blind_selected = SettingsDataContainer.get_colorblind_mode()
	connect("item_selected", Callable(self, "_on_daltonismo_selected"))
	select(GlobalAccesibilitySignal.color_blind_selected)

func save_value() -> void:
	SettingsSignalBus.emit_on_colorblind_mode_set(
		GlobalAccesibilitySignal.color_blind_selected)

func reset_value() -> void:
	set_state(SettingsDataContainer.get_colorblind_mode(true))

func set_state(index : int) -> void:
	selected = index
	_on_daltonismo_selected(index)

func _on_daltonismo_selected(index : int):
	var selected_option : String = get_item_text(index)
	#print(selected_option)
	GlobalAccesibilitySignal.emit_change_shader(index)
	GlobalAccesibilitySignal.color_blind_selected = index

func _on_visibility_changed() -> void:
	selected = GlobalAccesibilitySignal.color_blind_selected
