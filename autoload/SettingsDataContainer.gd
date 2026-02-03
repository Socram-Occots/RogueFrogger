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
var colorblind_mode : int = 0
# game data
var high_score : int = 0
var speedrun_dict : Dictionary = {}
# sandbox data
var sandbox_dict : Dictionary = {}
var sandbox_seed : String = ""
# challenge data
var challenge_dict : Dictionary = {}
var challenge_highschore_dict : Dictionary = {}

var loaded_data : Dictionary = {}
# aim toggle
var mouse_aim_toggle : bool = false
var controller_aim_toggle : bool = false
# logbook data
var logbook_dict : Dictionary = {}
# show hitboxes
var show_hitboxes : bool = false
# show controls
var show_controls : bool = false
# tutorials always on
var tutorials_always_on : bool = false

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
		"controller_aim_toggle": controller_aim_toggle,
		"logbook_dict": logbook_dict,
		"show_hitboxes": show_hitboxes,
		"show_controls": show_controls,
		"speedrun_dict": speedrun_dict,
		"tutorials_always_on": tutorials_always_on,
		"colorblind_mode": colorblind_mode,
		"challenge_highschore_dict": challenge_highschore_dict
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
		KEYBIND_RESOURCE.MOVE_THROW : KEYBIND_RESOURCE.move_throw_key,
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
		KEYBIND_RESOURCE.CONTROLLER_THROW : KEYBIND_RESOURCE.controller_throw,
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

func get_colorblind_mode(default : bool = false) -> int:
	if loaded_data.is_empty() || default:
		return DEFAULT_SETTINGS.default_colorblind_mode
	return colorblind_mode

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
			KEYBIND_RESOURCE.MOVE_THROW: return KEYBIND_RESOURCE.DEFAULT_MOVE_THROW_KEY
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
			KEYBIND_RESOURCE.CONTROLLER_THROW: return KEYBIND_RESOURCE.DEFAULT_CONTROLLER_THROW
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
			KEYBIND_RESOURCE.MOVE_THROW: return KEYBIND_RESOURCE.move_throw_key
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
			KEYBIND_RESOURCE.CONTROLLER_THROW: return KEYBIND_RESOURCE.controller_throw
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

func get_speedrun_dict_type(type: String, default : bool = false) -> float:
	if loaded_data.is_empty() || default:
		return DEFAULT_SETTINGS.default_speedrun_dict[type]
	return speedrun_dict[type]

func get_sandbox_dict(type: String, object: String, default : bool = false) -> int:
	if loaded_data.is_empty() || default:
		return DEFAULT_SETTINGS.default_sandbox_dict[type][object]
	return sandbox_dict[type][object]

func get_sandbox_dict_type(type: String, default : bool = false ) -> Dictionary:
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

# get logbook dict
func get_logbook_dict(type: String, object: String, default: bool = false) -> Array:
	if loaded_data.is_empty() || default:
		return DEFAULT_SETTINGS.default_logbook_dict[type][object]["bools"]
	return logbook_dict[type][object]["bools"]

func get_logbook_dict_tooltip(type: String, object: String, default: bool = false) -> String:
	if loaded_data.is_empty() || default:
		return DEFAULT_SETTINGS.default_logbook_dict[type][object]["tooltip"]
	return logbook_dict[type][object]["tooltip"]

func get_logbook_dict_popuptooltip(type: String, object: String, default: bool = false) -> String:
	if loaded_data.is_empty() || default:
		return DEFAULT_SETTINGS.default_logbook_dict[type][object]["popuptooltip"]
	return logbook_dict[type][object]["popuptooltip"]

func get_logbook_dict_stats(type: String, object: String, index : int, default: bool = false) -> int:
	if loaded_data.is_empty() || default:
		return DEFAULT_SETTINGS.default_logbook_dict[type][object]["stats"][index]
	return logbook_dict[type][object]["stats"][index]

func get_logbook_dict_type(type: String, default : bool = false ) -> Dictionary:
	if loaded_data.is_empty() || default:
		return DEFAULT_SETTINGS.default_logbook_dict[type]
	return logbook_dict[type]

# get show hitboxes
func get_show_hitboxes(default: bool = false) -> bool:
	if loaded_data.is_empty() || default:
		return DEFAULT_SETTINGS.default_show_hitboxes
	return show_hitboxes

# get show controls
func get_show_controls(default: bool = false) -> bool:
	if loaded_data.is_empty() || default:
		return DEFAULT_SETTINGS.default_show_controls
	return show_controls

# tutorials always on
func get_tutorials_always_on(default: bool = false) -> bool:
	if loaded_data.is_empty() || default:
		return DEFAULT_SETTINGS.default_tutorials_always_on
	return tutorials_always_on

# challenges
func get_challenges_All(default: bool = false) -> Dictionary:
	if loaded_data.is_empty() || default:
		return {}
	return challenge_dict

func get_challenges_dict(nameStr : String, default: bool = false) -> Dictionary:
	if loaded_data.is_empty() || default:
		return {}
	return challenge_dict[nameStr]

func get_challenges_Desc(nameStr : String, default: bool = false) -> String:
	if loaded_data.is_empty() || default:
		return ""
	return challenge_dict[nameStr]["Desc"]

func get_challenges_high_score(nameStr : String, default: bool = false) -> int:
	if loaded_data.is_empty() || default:
		return 0
	return challenge_highschore_dict[nameStr]

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

func on_colorblind_mode_set(index : int) -> void:
	colorblind_mode = index

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
		KEYBIND_RESOURCE.MOVE_THROW: KEYBIND_RESOURCE.move_throw_key = event
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
		KEYBIND_RESOURCE.CONTROLLER_THROW: KEYBIND_RESOURCE.controller_throw = event
		KEYBIND_RESOURCE.CONTROLLER_AIM_UP: KEYBIND_RESOURCE.controller_aim_up = event
		KEYBIND_RESOURCE.CONTROLLER_AIM_DOWN: KEYBIND_RESOURCE.controller_aim_down = event
		KEYBIND_RESOURCE.CONTROLLER_AIM_RIGHT: KEYBIND_RESOURCE.controller_aim_right = event
		KEYBIND_RESOURCE.CONTROLLER_AIM_LEFT: KEYBIND_RESOURCE.controller_aim_left = event
		_: print("Unable to find and set KEYBIND_RESOURCE: ", action)
# set game data
func on_high_score_set(value : int) -> void:
	high_score = value
func on_speedrun_dict_set(type: String, value: float) -> void:
	speedrun_dict[type] = value
func on_speedrun_dict_setAll(dict: Dictionary) -> void:
	var default : Dictionary = DEFAULT_SETTINGS.default_speedrun_dict
	for i in default.keys():
		if !dict.has(i):
			dict[i] = default[i]
	# getting rid of any unknown keys from other versions
	for i in dict.keys():
		if !default.has(i):
			dict.erase(i)
	speedrun_dict = dict.duplicate(true)

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
	KEYBIND_RESOURCE.CONTROLLER_AIM_RIGHT, KEYBIND_RESOURCE.CONTROLLER_AIM_LEFT,
	KEYBIND_RESOURCE.MOVE_THROW, KEYBIND_RESOURCE.CONTROLLER_THROW]
	for i in keybind_array:
		if data.has(i) && data[i] != null:
			set_keybind(i, data[i])
		else: set_keybind(i, get_keybind(i, true))

# set sandbox data
func on_sandbox_dict_set(type: String, object: String, num: int) -> void:
	sandbox_dict[type][object] = num

func on_sandbox_dict_setAll(dict : Dictionary) -> void:
	var default : Dictionary = DEFAULT_SETTINGS.default_sandbox_dict
	for i in default.keys():
		if dict.has(i):
			for a in default[i].keys():
				if !dict[i].has(a):
					dict[i][a] = default[i][a]
		else:
			dict[i] = default[i]
	# getting rid of any unknown keys from other versions
	for i in dict.keys():
		if default.has(i):
			for a in dict[i].keys():
				if !default[i].has(a):
					dict[i].erase(a)
		else:
			dict.erase(i)
	sandbox_dict = dict.duplicate(true)

func on_sandbox_seed_set(value: String) -> void:
	sandbox_seed = value

# set aim toggle
func on_mouse_aim_toggle_set(value : bool) -> void:
	mouse_aim_toggle = value
func on_controller_aim_toggle_set(value : bool) -> void:
	controller_aim_toggle = value

# set logbook dict
func on_logbook_dict_set(type : String, object : String, value : bool, index : int) -> void:
	logbook_dict[type][object]["bools"][index] = value

func on_logbook_dict_stats_set(type : String, object : String, value : int, index : int) -> void:
	logbook_dict[type][object]["stats"][index] = value

func on_logbook_dict_stats_inc(type : String, object : String, value : int, index : int) -> void:
	logbook_dict[type][object]["stats"][index] += value

# set show hitboxes
func on_show_hitboxes_set(value : bool) -> void:
	show_hitboxes = value

func on_logbook_dict_setAll(dict : Dictionary) -> void:
	var default : Dictionary = DEFAULT_SETTINGS.default_logbook_dict
	for i in default.keys():
		if dict.has(i):
			for a in default[i].keys():
				if dict[i].has(a):
					dict[i][a]["tooltip"] = default[i][a]["tooltip"]
					dict[i][a]["popuptooltip"] = default[i][a]["popuptooltip"]
					for b in default[i][a].keys():
						if !dict[i][a].has(b):
							dict[i][a][b] = default[i][a][b]
					# resize arrays if they are diff
					for c in ["bools", "stats"]:
						if dict[i][a][c].size() != default[i][a][c].size():
							dict[i][a][c].resize(default[i][a][c].size())
					
				else:
					dict[i][a] = default[i][a]
		else:
			dict[i] = default[i]
	# getting rid of any unknown/unused keys from other versions
	for i in dict.keys():
		if default.has(i):
			for a in dict[i].keys():
				if default[i].has(a):
					for b in dict[i][a].keys():
						if !default[i][a].has(b):
							dict[i][a].erase(b)
				else:
					dict[i].erase(a)
		else:
			dict.erase(i)
			
	logbook_dict = dict.duplicate(true)

# set controls
func on_show_controls_set(value : bool) -> void:
	show_controls = value

# always on tutorials
func on_tutorials_always_on_set(value : bool) -> void:
	tutorials_always_on = value

func on_challenges_set_dict() -> void:
	var GenerateChanllengesScript : Script = load("res://autoload/GenerateChanllenges.gd")
	var GenerateChanllenges : Node = GenerateChanllengesScript.new()
	challenge_dict = GenerateChanllenges.generate_challenges(
		DEFAULT_SETTINGS.default_sandbox_dict)
	GenerateChanllengesScript = null
	GenerateChanllenges.free()

func on_challenges_high_score_setDictAll(dict : Dictionary) -> void:
	for i in dict.keys():
		if !challenge_dict.has(i):
			dict.erase(i)
	for i in challenge_dict.keys():
		if !dict.has(i):
			dict[i] = 0
	
	challenge_highschore_dict = dict.duplicate(true)

func on_challenges_high_score_set(challenge : String, value : int) -> void:
	challenge_highschore_dict[challenge] = value

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
	if loaded_data.has("aspect_selected"):
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
	if loaded_data.has("logbook_dict"):
		on_logbook_dict_setAll(loaded_data["logbook_dict"])
	else:
		on_logbook_dict_setAll({})
	if loaded_data.has("show_hitboxes"):
		on_show_hitboxes_set(loaded_data["show_hitboxes"])
	else:
		on_show_hitboxes_set(DEFAULT_SETTINGS.default_show_hitboxes)
	if loaded_data.has("show_controls"):
		on_show_controls_set(loaded_data["show_controls"])
	else:
		on_show_controls_set(DEFAULT_SETTINGS.default_show_controls)
	if loaded_data.has("speedrun_dict"):
		on_speedrun_dict_setAll(loaded_data["speedrun_dict"])
	else:
		on_speedrun_dict_setAll({})
	if loaded_data.has("tutorials_always_on"):
		on_tutorials_always_on_set(loaded_data["tutorials_always_on"])
	else:
		on_tutorials_always_on_set(DEFAULT_SETTINGS.default_tutorials_always_on)
	if loaded_data.has("colorblind_mode"):
		on_colorblind_mode_set(loaded_data["colorblind_mode"])
	else:
		on_colorblind_mode_set(DEFAULT_SETTINGS.default_colorblind_mode)
	
	on_challenges_set_dict()
	if loaded_data.has("challenge_highschore_dict"):
		on_challenges_high_score_setDictAll(loaded_data["challenge_highschore_dict"])
	else:
		on_challenges_high_score_setDictAll({})
	
	loaded_data = create_storage_dictionary()

func handle_signals() -> void:
	# settings
	SettingsSignalBus.on_window_mode_selected.connect(on_window_mode_selected)
	SettingsSignalBus.on_resolution_selected.connect(on_resolution_selected)
	SettingsSignalBus.on_aspect_selected.connect(on_aspect_selected)
	SettingsSignalBus.on_master_sound_set.connect(on_master_sound_set)
	SettingsSignalBus.on_music_sound_set.connect(on_music_sound_set)
	SettingsSignalBus.on_sfx_sound_set.connect(on_sfx_sound_set)
	SettingsSignalBus.on_colorblind_mode_set.connect(on_colorblind_mode_set)
	# game data
	SettingsSignalBus.on_high_score_set.connect(on_high_score_set)
	SettingsSignalBus.on_speedrun_dict_set.connect(on_speedrun_dict_set)
	SettingsSignalBus.on_speedrun_dict_setAll.connect(on_speedrun_dict_setAll)
	# sandbox data
	SettingsSignalBus.on_sandbox_dict_set.connect(on_sandbox_dict_set)
	SettingsSignalBus.on_sandbox_dict_setAll.connect(on_sandbox_dict_setAll)
	SettingsSignalBus.on_sandbox_seed_set.connect(on_sandbox_seed_set)
	# aim toggle
	SettingsSignalBus.on_mouse_aim_toggle_set.connect(on_mouse_aim_toggle_set)
	SettingsSignalBus.on_controller_aim_toggle_set.connect(on_controller_aim_toggle_set)
	# logbook data
	SettingsSignalBus.on_logbook_dict_set.connect(on_logbook_dict_set)
	SettingsSignalBus.on_logbook_dict_stats_set.connect(on_logbook_dict_stats_set)
	SettingsSignalBus.on_logbook_dict_stats_inc.connect(on_logbook_dict_stats_inc)
	SettingsSignalBus.on_logbook_dict_setAll.connect(on_logbook_dict_setAll)
	# challenges data
	SettingsSignalBus.on_challenges_high_score_set.connect(on_challenges_high_score_set)
	SettingsSignalBus.on_challenges_high_score_setDictAll.connect(on_challenges_high_score_setDictAll)
	# show hitboxes
	SettingsSignalBus.on_show_hitboxes_set.connect(on_show_hitboxes_set)
	# show_controls
	SettingsSignalBus.on_show_controls_set.connect(on_show_controls_set)
	# always on tutorials
	SettingsSignalBus.on_tutorials_always_on_set.connect(on_tutorials_always_on_set)

	# load data
	SettingsSignalBus.load_settings_data.connect(on_settings_data_loaded)
