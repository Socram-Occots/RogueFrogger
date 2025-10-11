extends Control

@onready var option_button = $HBoxContainer/OptionButton as OptionButton
@export var group : String

const ASPECT_DICTIONARY : Dictionary = {
	"Off (Recommended)" : 1,
	"On" : 4
}

var ASPECT_DICTIONARY_KEYS : Array = ASPECT_DICTIONARY.keys()

func _ready():
	option_button.item_selected.connect(on_aspect_selected)
	add_aspect_items()
	load_data()
	select_current_aspect()
	add_to_group(group)

func load_data() -> void:
	on_aspect_selected(SettingsDataContainer.get_aspect_selected())

func add_aspect_items() -> void:
	for aspect_text in ASPECT_DICTIONARY.keys():
		option_button.add_item(aspect_text)

func on_aspect_selected(index: int) -> void:
	get_window().set_content_scale_aspect(ASPECT_DICTIONARY.values()[index])
	
func select_current_aspect() -> void:
	var index = ASPECT_DICTIONARY.values().find(get_window().content_scale_aspect)
	option_button.select(index)

func save_value() -> void:
	SettingsSignalBus.emit_on_aspect_selected(option_button.selected) 

func reset_value() -> void:
	var reset_idx : int = SettingsDataContainer.get_aspect_selected(true)
	on_aspect_selected(reset_idx) 
	option_button.select(reset_idx)
