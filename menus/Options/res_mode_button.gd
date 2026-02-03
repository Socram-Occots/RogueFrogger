extends Control

@onready var option_button = $HBoxContainer/OptionButton as OptionButton
@export var group : String

var RESOLUTION_DICTIONARY : Dictionary = {
	"480 x 234" : Vector2i(480, 234),
	"640 x 360" : Vector2i(640, 360),
	"960 x 540" : Vector2i(960, 540),
	"1024 x 576" : Vector2i(1024, 576),
	"1138 x 640" : Vector2i(1138, 640),
	"1280 x 720" : Vector2i(1280, 720),
	"1600 x 900" : Vector2i(1600, 900),
	"1920 x 1080" : Vector2i(1920, 1080),
	"2560 x 1440" : Vector2i(2560, 1440),
	"3840 x 2160" : Vector2i(3840, 2160),
	"5120 x 2880" : Vector2i(5120, 2880),
	"6016 x 3384" : Vector2i(6016, 3384),
	"7680 x 4320" : Vector2i(7680, 4320),
	"15360 x 8640" : Vector2i(15360, 8640)
}

var DISPLAY_RESOLUTION_KEYS : Array = RESOLUTION_DICTIONARY.keys()


func _ready():
	var current_screen : int = DisplayServer.window_get_current_screen()
	var displaysize : Vector2i = DisplayServer.screen_get_size(current_screen)
	remove_higher_res(displaysize.x, displaysize.y)
	option_button.item_selected.connect(on_resoltion_selected)
	add_resolution_items()
	load_data()
	select_current_display_resolution()
	add_to_group(group)

func remove_higher_res(viewportX: int, viewportY: int):
	var total_view_pixels : int = viewportX * viewportY
	for key in DISPLAY_RESOLUTION_KEYS:
		var tempres : Vector2i = RESOLUTION_DICTIONARY[key]
		if tempres.x * tempres.y > total_view_pixels:
			RESOLUTION_DICTIONARY.erase(key)
			
	DISPLAY_RESOLUTION_KEYS = RESOLUTION_DICTIONARY.keys()

func load_data() -> void:
	on_resoltion_selected(SettingsDataContainer.get_resolution_index())

func add_resolution_items() -> void:
	for resoltion_size_text in RESOLUTION_DICTIONARY:
		option_button.add_item(resoltion_size_text)
		
func on_resoltion_selected(index: int) -> void:
	# default dpi is 96
	#var dpi = DisplayServer.screen_get_dpi() as float
	if !Global.back_to_startscreen:
		DisplayServer.window_set_size(RESOLUTION_DICTIONARY.values()[index])
		center_window()
	
func center_window() -> void:
	var center_screen : Vector2i = DisplayServer.screen_get_position() + DisplayServer.screen_get_size()/2
	var window_size : Vector2i = get_window().get_size_with_decorations()
	get_window().set_position(center_screen - window_size/2)
	
func select_current_display_resolution() -> void:
	var current_resolution : Vector2i = DisplayServer.window_get_size()
	var current_resolution_string : String = str(current_resolution.x) + " x " + str(current_resolution.y)
	var index : int = DISPLAY_RESOLUTION_KEYS.find(current_resolution_string)
	option_button.select(index)

func save_value() -> void:
	SettingsSignalBus.emit_on_resolution_selected(option_button.selected)

func reset_value() -> void:
	var reset_idx : int = SettingsDataContainer.get_resolution_index(true)
	on_resoltion_selected(reset_idx) 
	option_button.select(reset_idx)
