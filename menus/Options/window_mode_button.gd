extends Control

@onready var option_button = $HBoxContainer/OptionButton as OptionButton
@export var group : String

const WINDOW_MODE_ARRAY : Array[String] = [
	"Full-Screen",
	"Window Mode",
	"Borderless Window Mode",
	"Borderless Full-Sreen"
]

func _ready():
	add_window_mode_items()
	option_button.item_selected.connect(on_window_mode_selected)
	load_data()
	select_current_window_mode()
	add_to_group(group)

func load_data() -> void:
	on_window_mode_selected(SettingsDataContainer.get_window_mode_index()) 
	
func add_window_mode_items() -> void:
	for window_mode in WINDOW_MODE_ARRAY:
		option_button.add_item(window_mode)
		
	
func on_window_mode_selected(index: int) -> void:
	if !Global.back_to_startscreen:
		match index:
			0: # fullscreen
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
				DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			1: # Window Mode
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
				DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			2: # Borderless Window Mode
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
				DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
			3: # Borderless Full-Sreen
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
				DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)

func select_current_window_mode() -> void:
	var mode = DisplayServer.window_get_mode()
	var borderless = DisplayServer.window_get_flag(DisplayServer.WINDOW_FLAG_BORDERLESS)
	match mode:
		DisplayServer.WINDOW_MODE_FULLSCREEN:
			if borderless:
				option_button.select(3)
			else:
				option_button.select(0)
		DisplayServer.WINDOW_MODE_WINDOWED:
			if borderless:
				option_button.select(2)
			else:
				option_button.select(1)
		_:
			pass

func save_value() -> void:
	SettingsSignalBus.emit_on_window_mode_selected(option_button.selected)

func reset_value() -> void:
	var reset_idx : int = SettingsDataContainer.get_window_mode_index(true)
	on_window_mode_selected(reset_idx) 
	option_button.select(reset_idx)
