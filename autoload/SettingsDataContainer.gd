extends Node

@onready var DEFAULT_SETTINGS : DefaultSettingsResource = preload("res://autoload/DefaultSettings.tres")
@onready var KEYBIND_RESOURCE : PlayerKeybindResource = preload("res://autoload/PlayerKeybindDefault.tres")

# settings
var window_mode_index : int = 0
var resolution_index : int = 0
var aspect_selected : int = 0
var master_volume : float = 0.0
var music_volume : float = 0.0
var sfx_volume : float = 0.0
# game data
var high_score : int = 0
# sandbox data
var sandbox_dict : Dictionary = {}
var sandbox_seed : String = ""

var loaded_data : Dictionary = {}
# aim toggle
var mouse_aim_toggle : bool = false
var controller_aim_toggle : bool = false

func _ready():
	handle_signals()
	
func create_storage_dictionary() -> Dictionary:
	var settings_container_dict : Dictionary = {
		"window_mode_index": window_mode_index,
		"resolution_index": resolution_index,
		"aspect_selected": aspect_selected,
		"master_volume": master_volume,
		"music_volume": music_volume,
		"sfx_volume": sfx_volume,
		"keybinds": create_keybind_dictionary(),
		"high_score": high_score,
		"sandbox_dict": sandbox_dict,
		"sandbox_seed": sandbox_seed,
		"mouse_aim_toggle": mouse_aim_toggle,
		"controller_aim_toggle": controller_aim_toggle
	}

	return settings_container_dict

func create_keybind_dictionary() -> Dictionary:
	var keybinds_container_dict = {
		KEYBIND_RESOURCE.MOVE_UP : KEYBIND_RESOURCE.move_up_key,
		KEYBIND_RESOURCE.MOVE_DOWN : KEYBIND_RESOURCE.move_down_key,
		KEYBIND_RESOURCE.MOVE_RIGHT : KEYBIND_RESOURCE.move_right_key,
		KEYBIND_RESOURCE.MOVE_LEFT : KEYBIND_RESOURCE.move_left_key,
		KEYBIND_RESOURCE.MOVE_DASH : KEYBIND_RESOURCE.move_dash_key,
		KEYBIND_RESOURCE.MOVE_WALK : KEYBIND_RESOURCE.move_walk_key,
		KEYBIND_RESOURCE.MOVE_ROPE : KEYBIND_RESOURCE.move_rope_key,
		KEYBIND_RESOURCE.MOVE_GLIDE : KEYBIND_RESOURCE.move_glide_key,
		KEYBIND_RESOURCE.CONTROLLER_UP_STICK : KEYBIND_RESOURCE.controller_up_stick,
		KEYBIND_RESOURCE.CONTROLLER_DOWN_STICK : KEYBIND_RESOURCE.controller_down_stick,
		KEYBIND_RESOURCE.CONTROLLER_RIGHT_STICK : KEYBIND_RESOURCE.controller_right_stick,
		KEYBIND_RESOURCE.CONTROLLER_LEFT_STICK : KEYBIND_RESOURCE.controller_left_stick,
		KEYBIND_RESOURCE.CONTROLLER_UP_BUTTON : KEYBIND_RESOURCE.controller_up_button,
		KEYBIND_RESOURCE.CONTROLLER_DOWN_BUTTON : KEYBIND_RESOURCE.controller_down_button,
		KEYBIND_RESOURCE.CONTROLLER_RIGHT_BUTTON : KEYBIND_RESOURCE.controller_right_button,
		KEYBIND_RESOURCE.CONTROLLER_LEFT_BUTTON : KEYBIND_RESOURCE.controller_left_button,
		KEYBIND_RESOURCE.CONTROLLER_DASH : KEYBIND_RESOURCE.controller_dash,
		KEYBIND_RESOURCE.CONTROLLER_WALK : KEYBIND_RESOURCE.controller_walk,
		KEYBIND_RESOURCE.CONTROLLER_ROPE : KEYBIND_RESOURCE.controller_rope,
		KEYBIND_RESOURCE.CONTROLLER_GLIDE : KEYBIND_RESOURCE.controller_glide,
		KEYBIND_RESOURCE.CONTROLLER_AIM_UP : KEYBIND_RESOURCE.controller_aim_up,
		KEYBIND_RESOURCE.CONTROLLER_AIM_DOWN : KEYBIND_RESOURCE.controller_aim_down,
		KEYBIND_RESOURCE.CONTROLLER_AIM_RIGHT : KEYBIND_RESOURCE.controller_aim_right,
		KEYBIND_RESOURCE.CONTROLLER_AIM_LEFT : KEYBIND_RESOURCE.controller_aim_left
	}
	return keybinds_container_dict

# get settings
func get_window_mode_index(default : bool = false) -> int:
	if loaded_data.is_empty() || default:
		return DEFAULT_SETTINGS.default_window_mode_index
	return window_mode_index
	
func get_resolution_index(default : bool = false) -> int:
	if loaded_data.is_empty() || default:
		return DEFAULT_SETTINGS.default_resolution_index
	return resolution_index
	
func get_aspect_selected(default : bool = false) -> int:
	if loaded_data.is_empty() || default:
		return DEFAULT_SETTINGS.default_aspect_selected
	return aspect_selected
	
func get_master_volume(default : bool = false) -> float:
	if loaded_data.is_empty() || default:
		return DEFAULT_SETTINGS.default_master_volume
	return master_volume
	
func get_music_volume(default : bool = false) -> float:
	if loaded_data.is_empty() || default:
		return DEFAULT_SETTINGS.default_music_volume
	return music_volume
	
func get_sfx_volume(default : bool = false) -> float:
	if loaded_data.is_empty() || default:
		return DEFAULT_SETTINGS.default_sfx_volume
	return sfx_volume

# get keybinds
func get_keybind(action: String, default : bool = false):
	if !loaded_data.has("keybinds") || default:
		match action:
			KEYBIND_RESOURCE.MOVE_UP: return KEYBIND_RESOURCE.DEFAULT_MOVE_UP_KEY
			KEYBIND_RESOURCE.MOVE_DOWN: return KEYBIND_RESOURCE.DEFAULT_MOVE_DOWN_KEY
			KEYBIND_RESOURCE.MOVE_RIGHT: return KEYBIND_RESOURCE.DEFAULT_MOVE_RIGHT_KEY
			KEYBIND_RESOURCE.MOVE_LEFT: return KEYBIND_RESOURCE.DEFAULT_MOVE_LEFT_KEY
			KEYBIND_RESOURCE.MOVE_DASH: return KEYBIND_RESOURCE.DEFAULT_MOVE_DASH_KEY
			KEYBIND_RESOURCE.MOVE_WALK: return KEYBIND_RESOURCE.DEFAULT_MOVE_WALK_KEY
			KEYBIND_RESOURCE.MOVE_ROPE: return KEYBIND_RESOURCE.DEFAULT_MOVE_ROPE_KEY
			KEYBIND_RESOURCE.MOVE_GLIDE: return KEYBIND_RESOURCE.DEFAULT_MOVE_GLIDE_KEY
			KEYBIND_RESOURCE.CONTROLLER_UP_STICK: return KEYBIND_RESOURCE.DEFAULT_CONTROLLER_UP_STICK
			KEYBIND_RESOURCE.CONTROLLER_DOWN_STICK: return KEYBIND_RESOURCE.DEFAULT_CONTROLLER_DOWN_STICK
			KEYBIND_RESOURCE.CONTROLLER_RIGHT_STICK: return KEYBIND_RESOURCE.DEFAULT_CONTROLLER_RIGHT_STICK
			KEYBIND_RESOURCE.CONTROLLER_LEFT_STICK: return KEYBIND_RESOURCE.DEFAULT_CONTROLLER_LEFT_STICK
			KEYBIND_RESOURCE.CONTROLLER_UP_BUTTON: return KEYBIND_RESOURCE.DEFAULT_CONTROLLER_UP_BUTTON
			KEYBIND_RESOURCE.CONTROLLER_DOWN_BUTTON: return KEYBIND_RESOURCE.DEFAULT_CONTROLLER_DOWN_BUTTON
			KEYBIND_RESOURCE.CONTROLLER_RIGHT_BUTTON: return KEYBIND_RESOURCE.DEFAULT_CONTROLLER_RIGHT_BUTTON
			KEYBIND_RESOURCE.CONTROLLER_LEFT_BUTTON: return KEYBIND_RESOURCE.DEFAULT_CONTROLLER_LEFT_BUTTON
			KEYBIND_RESOURCE.CONTROLLER_DASH: return KEYBIND_RESOURCE.DEFAULT_CONTROLLER_DASH
			KEYBIND_RESOURCE.CONTROLLER_WALK: return KEYBIND_RESOURCE.DEFAULT_CONTROLLER_WALK
			KEYBIND_RESOURCE.CONTROLLER_ROPE: return KEYBIND_RESOURCE.DEFAULT_CONTROLLER_ROPE
			KEYBIND_RESOURCE.CONTROLLER_GLIDE: return KEYBIND_RESOURCE.DEFAULT_CONTROLLER_GLIDE
			KEYBIND_RESOURCE.CONTROLLER_AIM_UP: return KEYBIND_RESOURCE.DEFAULT_CONTROLLER_AIM_UP
			KEYBIND_RESOURCE.CONTROLLER_AIM_DOWN: return KEYBIND_RESOURCE.DEFAULT_CONTROLLER_AIM_DOWN
			KEYBIND_RESOURCE.CONTROLLER_AIM_RIGHT: return KEYBIND_RESOURCE.DEFAULT_CONTROLLER_AIM_RIGHT
			KEYBIND_RESOURCE.CONTROLLER_AIM_LEFT: return KEYBIND_RESOURCE.DEFAULT_CONTROLLER_AIM_LEFT
			_: print("Failed to get default keybind: ", action)
	else:
		match action:
			KEYBIND_RESOURCE.MOVE_UP: return KEYBIND_RESOURCE.move_up_key
			KEYBIND_RESOURCE.MOVE_DOWN: return KEYBIND_RESOURCE.move_down_key
			KEYBIND_RESOURCE.MOVE_RIGHT: return KEYBIND_RESOURCE.move_right_key
			KEYBIND_RESOURCE.MOVE_LEFT: return KEYBIND_RESOURCE.move_left_key
			KEYBIND_RESOURCE.MOVE_DASH: return KEYBIND_RESOURCE.move_dash_key
			KEYBIND_RESOURCE.MOVE_WALK: return KEYBIND_RESOURCE.move_walk_key
			KEYBIND_RESOURCE.MOVE_ROPE: return KEYBIND_RESOURCE.move_rope_key
			KEYBIND_RESOURCE.MOVE_GLIDE: return KEYBIND_RESOURCE.move_glide_key
			KEYBIND_RESOURCE.CONTROLLER_UP_STICK: return KEYBIND_RESOURCE.controller_up_stick
			KEYBIND_RESOURCE.CONTROLLER_DOWN_STICK: return KEYBIND_RESOURCE.controller_down_stick
			KEYBIND_RESOURCE.CONTROLLER_RIGHT_STICK: return KEYBIND_RESOURCE.controller_right_stick
			KEYBIND_RESOURCE.CONTROLLER_LEFT_STICK: return KEYBIND_RESOURCE.controller_left_stick
			KEYBIND_RESOURCE.CONTROLLER_UP_BUTTON: return KEYBIND_RESOURCE.controller_up_button
			KEYBIND_RESOURCE.CONTROLLER_DOWN_BUTTON: return KEYBIND_RESOURCE.controller_down_button
			KEYBIND_RESOURCE.CONTROLLER_RIGHT_BUTTON: return KEYBIND_RESOURCE.controller_right_button
			KEYBIND_RESOURCE.CONTROLLER_LEFT_BUTTON: return KEYBIND_RESOURCE.controller_left_button
			KEYBIND_RESOURCE.CONTROLLER_DASH: return KEYBIND_RESOURCE.controller_dash
			KEYBIND_RESOURCE.CONTROLLER_WALK: return KEYBIND_RESOURCE.controller_walk
			KEYBIND_RESOURCE.CONTROLLER_ROPE: return KEYBIND_RESOURCE.controller_rope
			KEYBIND_RESOURCE.CONTROLLER_GLIDE: return KEYBIND_RESOURCE.controller_glide
			KEYBIND_RESOURCE.CONTROLLER_AIM_UP: return KEYBIND_RESOURCE.controller_aim_up
			KEYBIND_RESOURCE.CONTROLLER_AIM_DOWN: return KEYBIND_RESOURCE.controller_aim_down
			KEYBIND_RESOURCE.CONTROLLER_AIM_RIGHT: return KEYBIND_RESOURCE.controller_aim_right
			KEYBIND_RESOURCE.CONTROLLER_AIM_LEFT: return KEYBIND_RESOURCE.controller_aim_left
			_: print("Failed to get keybind: ", action)
# get game data
func get_high_score(default : bool = false) -> int:
	if loaded_data.is_empty() || default:
		return DEFAULT_SETTINGS.default_high_score
	return high_score
	
func get_sandbox_dict(type: String, object: String, default : bool = false) -> int:
	if loaded_data.is_empty() || default:
		return DEFAULT_SETTINGS.default_sandbox_dict[type][object]
	return sandbox_dict[type][object]

func get_sandbox_dict_type(type: String, default : bool = false ) -> Dictionary:
	print(loaded_data.is_empty())
	if loaded_data.is_empty() || default:
		return DEFAULT_SETTINGS.default_sandbox_dict[type]
	return sandbox_dict[type]

func get_sandbox_seed(default : bool = false) -> String:
	if loaded_data.is_empty() || default:
		return DEFAULT_SETTINGS.default_sandbox_seed
	return sandbox_seed

# get aim toggle 
func get_mouse_aim_toggle(default: bool = false) -> bool:
	if loaded_data.is_empty() || default:
		return DEFAULT_SETTINGS.default_mouse_aim_toggle
	return mouse_aim_toggle

func get_controller_aim_toggle(default: bool = false) -> bool:
	if loaded_data.is_empty() || default:
		return DEFAULT_SETTINGS.default_controller_aim_toggle
	return controller_aim_toggle

# set settings
func on_window_mode_selected(index : int) -> void:
	window_mode_index = index

func on_resolution_selected(index : int) -> void:
	resolution_index = index

func on_aspect_selected(index: int) -> void:
	aspect_selected = index

func on_master_sound_set(value : float) -> void:
	master_volume = value

func on_music_sound_set(value : float) -> void:
	music_volume = value

func on_sfx_sound_set(value : float) -> void:
	sfx_volume = value
# set keybind 
func set_keybind(action: String, event) -> void:
	match action:
		KEYBIND_RESOURCE.MOVE_UP: KEYBIND_RESOURCE.move_up_key = event
		KEYBIND_RESOURCE.MOVE_DOWN: KEYBIND_RESOURCE.move_down_key = event
		KEYBIND_RESOURCE.MOVE_RIGHT: KEYBIND_RESOURCE.move_right_key = event
		KEYBIND_RESOURCE.MOVE_LEFT: KEYBIND_RESOURCE.move_left_key = event
		KEYBIND_RESOURCE.MOVE_DASH: KEYBIND_RESOURCE.move_dash_key = event
		KEYBIND_RESOURCE.MOVE_WALK: KEYBIND_RESOURCE.move_walk_key = event
		KEYBIND_RESOURCE.MOVE_ROPE: KEYBIND_RESOURCE.move_rope_key = event
		KEYBIND_RESOURCE.MOVE_GLIDE: KEYBIND_RESOURCE.move_glide_key = event
		KEYBIND_RESOURCE.CONTROLLER_UP_STICK: KEYBIND_RESOURCE.controller_up_stick = event
		KEYBIND_RESOURCE.CONTROLLER_DOWN_STICK: KEYBIND_RESOURCE.controller_down_stick = event
		KEYBIND_RESOURCE.CONTROLLER_RIGHT_STICK: KEYBIND_RESOURCE.controller_right_stick = event
		KEYBIND_RESOURCE.CONTROLLER_LEFT_STICK: KEYBIND_RESOURCE.controller_left_stick = event
		KEYBIND_RESOURCE.CONTROLLER_UP_BUTTON: KEYBIND_RESOURCE.controller_up_button = event
		KEYBIND_RESOURCE.CONTROLLER_DOWN_BUTTON: KEYBIND_RESOURCE.controller_down_button = event
		KEYBIND_RESOURCE.CONTROLLER_RIGHT_BUTTON: KEYBIND_RESOURCE.controller_right_button = event
		KEYBIND_RESOURCE.CONTROLLER_LEFT_BUTTON: KEYBIND_RESOURCE.controller_left_button = event
		KEYBIND_RESOURCE.CONTROLLER_DASH: KEYBIND_RESOURCE.controller_dash = event
		KEYBIND_RESOURCE.CONTROLLER_WALK: KEYBIND_RESOURCE.controller_walk = event
		KEYBIND_RESOURCE.CONTROLLER_ROPE: KEYBIND_RESOURCE.controller_rope = event
		KEYBIND_RESOURCE.CONTROLLER_GLIDE: KEYBIND_RESOURCE.controller_glide = event
		KEYBIND_RESOURCE.CONTROLLER_AIM_UP: KEYBIND_RESOURCE.controller_aim_up = event
		KEYBIND_RESOURCE.CONTROLLER_AIM_DOWN: KEYBIND_RESOURCE.controller_aim_down = event
		KEYBIND_RESOURCE.CONTROLLER_AIM_RIGHT: KEYBIND_RESOURCE.controller_aim_right = event
		KEYBIND_RESOURCE.CONTROLLER_AIM_LEFT: KEYBIND_RESOURCE.controller_aim_left = event
		_: print("Unable to find and set KEYBIND_RESOURCE: ", action)
# set game data
func on_high_score_set(value : int) -> void:
	high_score = value

func on_keybinds_loaded(data: Dictionary) -> void:
	var keybind_array : Array[String] = \
	[KEYBIND_RESOURCE.MOVE_UP, KEYBIND_RESOURCE.MOVE_DOWN,
	KEYBIND_RESOURCE.MOVE_RIGHT, KEYBIND_RESOURCE.MOVE_LEFT, KEYBIND_RESOURCE.MOVE_DASH,
	KEYBIND_RESOURCE.MOVE_WALK, KEYBIND_RESOURCE.MOVE_ROPE, KEYBIND_RESOURCE.MOVE_GLIDE,
	KEYBIND_RESOURCE.CONTROLLER_UP_STICK, KEYBIND_RESOURCE.CONTROLLER_DOWN_STICK, 
	KEYBIND_RESOURCE.CONTROLLER_RIGHT_STICK, KEYBIND_RESOURCE.CONTROLLER_LEFT_STICK,
	KEYBIND_RESOURCE.CONTROLLER_UP_BUTTON, KEYBIND_RESOURCE.CONTROLLER_DOWN_BUTTON, 
	KEYBIND_RESOURCE.CONTROLLER_RIGHT_BUTTON, KEYBIND_RESOURCE.CONTROLLER_LEFT_BUTTON,
	KEYBIND_RESOURCE.CONTROLLER_DASH, KEYBIND_RESOURCE.CONTROLLER_WALK,
	KEYBIND_RESOURCE.CONTROLLER_ROPE, KEYBIND_RESOURCE.CONTROLLER_GLIDE,
	KEYBIND_RESOURCE.CONTROLLER_AIM_UP, KEYBIND_RESOURCE.CONTROLLER_AIM_DOWN,
	KEYBIND_RESOURCE.CONTROLLER_AIM_RIGHT, KEYBIND_RESOURCE.CONTROLLER_AIM_LEFT]
	for i in keybind_array:
		if data.has(i) && data[i] != null:
			set_keybind(i, data[i])
		else: set_keybind(i, get_keybind(i, true))

# set sandbox data
func on_sandbox_dict_set(type: String, object: String, num: int) -> void:
	sandbox_dict[type][object] = num

func on_sandbox_dict_setAll(dict : Dictionary) -> void:
	var default : Dictionary = DEFAULT_SETTINGS.default_sandbox_dict
	for i in DEFAULT_SETTINGS.default_sandbox_dict.keys():
		if dict.has(i):
			for a in default[i].keys():
				if !dict[i].has(a):
					dict[i][a] = default[i][a]
		else:
			dict[i] = default[i]
	sandbox_dict = dict.duplicate(true)

func on_sandbox_seed_set(value: String) -> void:
	sandbox_seed = value

# set aim toggle
func on_mouse_aim_toggle_set(value : bool) -> void:
	mouse_aim_toggle = value
func on_controller_aim_toggle_set(value : bool) -> void:
	controller_aim_toggle = value

#settings data set
func on_settings_data_loaded(data: Dictionary) -> void:
	loaded_data = data
	# settings
	if loaded_data.has("window_mode_index"):
		on_window_mode_selected(loaded_data["window_mode_index"])
	else:
		on_window_mode_selected(DEFAULT_SETTINGS.default_window_mode_index)
	if loaded_data.has("resolution_index"):
		on_resolution_selected(loaded_data["resolution_index"])
	else:
		on_resolution_selected(DEFAULT_SETTINGS.default_resolution_index)
	if loaded_data.has(aspect_selected):
		on_aspect_selected(loaded_data["aspect_selected"])
	else:
		on_aspect_selected(DEFAULT_SETTINGS.default_aspect_selected)
	if loaded_data.has("master_volume"):
		on_master_sound_set(loaded_data["master_volume"])
	else:
		on_master_sound_set(DEFAULT_SETTINGS.default_master_volume)
	if loaded_data.has("music_volume"):
		on_music_sound_set(loaded_data["music_volume"])
	else:
		on_music_sound_set(DEFAULT_SETTINGS.default_music_volume)
	if loaded_data.has("sfx_volume"):
		on_sfx_sound_set(loaded_data["sfx_volume"])
	else:
		on_sfx_sound_set(DEFAULT_SETTINGS.default_sfx_volume)
	if loaded_data.has("keybinds"):
		on_keybinds_loaded(loaded_data["keybinds"])
	else:
		on_keybinds_loaded({})
	# game data
	if loaded_data.has("high_score"):
		on_high_score_set(loaded_data["high_score"])
	else:
		on_high_score_set(DEFAULT_SETTINGS.default_high_score)
	# sandbox data
	if loaded_data.has("sandbox_dict"):
		on_sandbox_dict_setAll(loaded_data["sandbox_dict"])
	else:
		on_sandbox_dict_setAll({})
	if loaded_data.has("sandbox_seed"):
		on_sandbox_seed_set(loaded_data["sandbox_seed"])
	else:
		on_sandbox_seed_set(DEFAULT_SETTINGS.default_sandbox_seed)
	if loaded_data.has("mouse_aim_toggle"):
		on_mouse_aim_toggle_set(loaded_data["mouse_aim_toggle"])
	else:
		on_mouse_aim_toggle_set(DEFAULT_SETTINGS.default_mouse_aim_toggle)
	if loaded_data.has("controller_aim_toggle"):
		on_controller_aim_toggle_set(loaded_data["controller_aim_toggle"])
	else:
		on_controller_aim_toggle_set(DEFAULT_SETTINGS.default_controller_aim_toggle)
	
	loaded_data = create_storage_dictionary()

func handle_signals() -> void:
	# settings
	SettingsSignalBus.on_window_mode_selected.connect(on_window_mode_selected)
	SettingsSignalBus.on_resolution_selected.connect(on_resolution_selected)
	SettingsSignalBus.on_aspect_selected.connect(on_aspect_selected)
	SettingsSignalBus.on_master_sound_set.connect(on_master_sound_set)
	SettingsSignalBus.on_music_sound_set.connect(on_music_sound_set)
	SettingsSignalBus.on_sfx_sound_set.connect(on_sfx_sound_set)
	# game data
	SettingsSignalBus.on_high_score_set.connect(on_high_score_set)
	# sandbox data
	SettingsSignalBus.on_sandbox_dict_set.connect(on_sandbox_dict_set)
	SettingsSignalBus.on_sandbox_dict_setAll.connect(on_sandbox_dict_setAll)
	SettingsSignalBus.on_sandbox_seed_set.connect(on_sandbox_seed_set)
	# aim toggle
	SettingsSignalBus.on_mouse_aim_toggle_set.connect(on_mouse_aim_toggle_set)
	SettingsSignalBus.on_controller_aim_toggle_set.connect(on_controller_aim_toggle_set)

	# load data
	SettingsSignalBus.load_settings_data.connect(on_settings_data_loaded)
