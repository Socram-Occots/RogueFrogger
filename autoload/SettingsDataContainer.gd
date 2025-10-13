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

var loaded_data : Dictionary = {}

func _ready():
	handle_signals()
	create_storage_dictionary()
	
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
		"sandbox_dict": sandbox_dict
	}

	return settings_container_dict

func create_keybind_dictionary() -> Dictionary:
	var keybinds_container_dict = {
		KEYBIND_RESOURCE.MOVE_UP : KEYBIND_RESOURCE.move_up_key,
		KEYBIND_RESOURCE.MOVE_DOWN : KEYBIND_RESOURCE.move_down_key,
		KEYBIND_RESOURCE.MOVE_RIGHT : KEYBIND_RESOURCE.move_right_key,
		KEYBIND_RESOURCE.MOVE_LEFT : KEYBIND_RESOURCE.move_left_key,
		KEYBIND_RESOURCE.MOVE_DASH : KEYBIND_RESOURCE.move_dash_key,
		KEYBIND_RESOURCE.MOVE_WALK : KEYBIND_RESOURCE.move_walk_key
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
			KEYBIND_RESOURCE.MOVE_UP:
				return KEYBIND_RESOURCE.DEFAULT_MOVE_UP_KEY
			KEYBIND_RESOURCE.MOVE_DOWN:
				return KEYBIND_RESOURCE.DEFAULT_MOVE_DOWN_KEY
			KEYBIND_RESOURCE.MOVE_RIGHT:
				return KEYBIND_RESOURCE.DEFAULT_MOVE_RIGHT_KEY
			KEYBIND_RESOURCE.MOVE_LEFT:
				return KEYBIND_RESOURCE.DEFAULT_MOVE_LEFT_KEY
			KEYBIND_RESOURCE.MOVE_DASH:
				return KEYBIND_RESOURCE.DEFAULT_MOVE_DASH_KEY
			KEYBIND_RESOURCE.MOVE_WALK:
				return KEYBIND_RESOURCE.DEFAULT_MOVE_WALK_KEY
	else:
		match action:
			KEYBIND_RESOURCE.MOVE_UP:
				return KEYBIND_RESOURCE.move_up_key
			KEYBIND_RESOURCE.MOVE_DOWN:
				return KEYBIND_RESOURCE.move_down_key
			KEYBIND_RESOURCE.MOVE_RIGHT:
				return KEYBIND_RESOURCE.move_right_key
			KEYBIND_RESOURCE.MOVE_LEFT:
				return KEYBIND_RESOURCE.move_left_key
			KEYBIND_RESOURCE.MOVE_DASH:
				return KEYBIND_RESOURCE.move_dash_key
			KEYBIND_RESOURCE.MOVE_WALK:
				return KEYBIND_RESOURCE.move_walk_key
				
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
	if loaded_data.is_empty() || default:
		return DEFAULT_SETTINGS.default_sandbox_dict[type]
	return sandbox_dict[type]

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
		KEYBIND_RESOURCE.MOVE_UP:
			KEYBIND_RESOURCE.move_up_key = event
		KEYBIND_RESOURCE.MOVE_DOWN:
			KEYBIND_RESOURCE.move_down_key = event
		KEYBIND_RESOURCE.MOVE_RIGHT:
			KEYBIND_RESOURCE.move_right_key = event
		KEYBIND_RESOURCE.MOVE_LEFT:
			KEYBIND_RESOURCE.move_left_key = event
		KEYBIND_RESOURCE.MOVE_DASH:
			KEYBIND_RESOURCE.move_dash_key = event
		KEYBIND_RESOURCE.MOVE_WALK:
			KEYBIND_RESOURCE.move_walk_key = event
# set game data
func on_high_score_set(value : int) -> void:
	high_score = value

func on_keybinds_loaded(data: Dictionary) -> void:
	if data.has("up_w"):
		var loaded_move_up = InputEventKey.new()
		loaded_move_up.set_physical_keycode(int(data["up_w"]))
		KEYBIND_RESOURCE.move_up_key = loaded_move_up
	else:
		KEYBIND_RESOURCE.move_up_key = KEYBIND_RESOURCE.DEFAULT_MOVE_UP_KEY
	if data.has("down_s"):
		var loaded_move_down = InputEventKey.new()
		loaded_move_down.set_physical_keycode(int(data["down_s"]))
		KEYBIND_RESOURCE.move_down_key = loaded_move_down
	else:
		KEYBIND_RESOURCE.move_down_key = KEYBIND_RESOURCE.DEFAULT_MOVE_DOWN_KEY
	if data.has("right_d"):
		var loaded_move_right = InputEventKey.new()
		loaded_move_right.set_physical_keycode(int(data["right_d"]))
		KEYBIND_RESOURCE.move_right_key = loaded_move_right
	else:
		KEYBIND_RESOURCE.move_right_key = KEYBIND_RESOURCE.DEFAULT_MOVE_RIGHT_KEY
	if data.has("left_a"):
		var loaded_move_left = InputEventKey.new()
		loaded_move_left.set_physical_keycode(int(data["left_a"]))
		KEYBIND_RESOURCE.move_left_key = loaded_move_left
	else:
		KEYBIND_RESOURCE.move_left_key = KEYBIND_RESOURCE.DEFAULT_MOVE_LEFT_KEY
	if data.has("dash"):
		var loaded_move_dash = InputEventKey.new()
		loaded_move_dash.set_physical_keycode(int(data["dash"]))
		KEYBIND_RESOURCE.move_dash_key = loaded_move_dash
	else:
		KEYBIND_RESOURCE.move_dash_key = KEYBIND_RESOURCE.DEFAULT_MOVE_DASH_KEY
	if data.has("walk"):
		var loaded_move_walk = InputEventKey.new()
		loaded_move_walk.set_physical_keycode(int(data["walk"]))
		KEYBIND_RESOURCE.move_walk_key = loaded_move_walk
	else:
		KEYBIND_RESOURCE.move_walk_key = KEYBIND_RESOURCE.DEFAULT_MOVE_WALK_KEY

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
	# load data
	SettingsSignalBus.load_settings_data.connect(on_settings_data_loaded)
