extends Node

# settings
signal on_window_mode_selected(index: int)
signal on_resolution_selected(index: int)
signal on_aspect_selected(index: int)
signal on_master_sound_set(value: float)
signal on_music_sound_set(value: float)
signal on_sfx_sound_set(value: float)
signal on_colorblind_mode_set(index: int)
# game data
signal on_high_score_set(value: int)
signal on_speedrun_dict_set(type: String, value: float)
signal on_speedrun_dict_setAll(dict: Dictionary)
# sandbox data
signal on_sandbox_dict_set(type: String, object: String, num: int)
signal on_sandbox_dict_setAll(dict: Dictionary)
signal on_sandbox_seed_set(value: String)
# aim toggle
signal on_mouse_aim_toggle_set(value: bool)
signal on_controller_aim_toggle_set(value: bool)
# logbook data
signal on_logbook_dict_set(type : String, object : String, value : bool, index : int)
signal on_logbook_dict_stats_set(type : String, object : String, value : int, index : int)
signal on_logbook_dict_stats_inc(type : String, object : String, value : int, index : int)
signal on_logbook_dict_setAll(dict: Dictionary)
# challenges data
signal on_challenges_high_score_setDictAll(dict : Dictionary)
signal on_challenges_high_score_set(challenge : String, value : int)
# show hitboxes
signal on_show_hitboxes_set(value : bool)
# show controls
signal on_show_controls_set(value : bool)
# on tutorials always
signal on_tutorials_always_on_set(value : bool)

signal set_settings_dictionary(settings_dict : Dictionary)

signal load_settings_data(settings_dict : Dictionary)

signal on_reached_50_score_set(value : bool)

func emit_load_settings_data(settings_dict : Dictionary) -> void:
	load_settings_data.emit(settings_dict)

func emit_set_settings_dictionary(settings_dict : Dictionary) -> void:
	set_settings_dictionary.emit(settings_dict)

# settings
func emit_on_window_mode_selected(index: int) -> void:
	on_window_mode_selected.emit(index)
func emit_on_resolution_selected(index: int) -> void:
	on_resolution_selected.emit(index)
func emit_on_aspect_selected(index: int) -> void:
	on_aspect_selected.emit(index)
func emit_on_master_sound_set(value: float) -> void:
	on_master_sound_set.emit(value)
func emit_on_music_sound_set(value: float) -> void:
	on_music_sound_set.emit(value)
func emit_on_sfx_sound_set(value: float) -> void:
	on_sfx_sound_set.emit(value)
func emit_on_colorblind_mode_set(index: int) -> void:
	on_colorblind_mode_set.emit(index)
# game data
func emit_on_high_score_set(value: int) -> void:
	on_high_score_set.emit(value)
func emit_on_speedrun_dict_set(type: String, value: float) -> void:
	on_speedrun_dict_set.emit(type, value)
func emit_on_speedrun_dict_setAll(dict: Dictionary) -> void:
	on_speedrun_dict_setAll.emit(dict)
# sandbox data
func emit_on_sandbox_dict_set(type: String, object: String, num: int) -> void:
	on_sandbox_dict_set.emit(type, object, num)
func emit_on_sandbox_dict_setAll(dict : Dictionary) -> void:
	on_sandbox_dict_setAll.emit(dict)
func emit_on_sandbox_seed_set(value: String) -> void:
	on_sandbox_seed_set.emit(value)
# aim mode
func emit_on_mouse_aim_toggle_set(value: bool) -> void:
	on_mouse_aim_toggle_set.emit(value)
func emit_on_controller_aim_toggle_set(value: bool) -> void:
	on_controller_aim_toggle_set.emit(value)
# logbook data
func emit_on_logbook_dict_set(type : String, object : String, value : bool, index : int) -> void:
	on_logbook_dict_set.emit(type, object, value, index)
func emit_on_logbook_dict_stats_set(type : String, object : String, value : bool, index : int) -> void:
	on_logbook_dict_stats_set.emit(type, object, value, index)
func emit_on_logbook_dict_stats_inc(type : String, object : String, value : int, index : int) -> void:
	on_logbook_dict_stats_inc.emit(type, object, value, index)
func emit_on_logbook_dict_setAll(dict : Dictionary) -> void:
	on_logbook_dict_setAll.emit(dict)
# challenges data
func emit_on_challenges_high_score_setDictAll(dict : Dictionary) -> void:
	on_challenges_high_score_setDictAll.emit(dict)
func emit_on_challenges_high_score_set(challenge : String, value : int) -> void:
	on_challenges_high_score_set.emit(challenge, value)
# show hitboxes
func emit_on_show_hitboxes_set(value : bool) -> void:
	on_show_hitboxes_set.emit(value)
# show controls
func emit_on_show_controls_set(value : bool) -> void:
	on_show_controls_set.emit(value)
# always on tutorials
func emit_on_tutorials_always_on_set(value : bool) -> void:
	on_tutorials_always_on_set.emit(value)
	
func emit_on_reached_50_score_set(value : bool) -> void:
	on_reached_50_score_set.emit(value)
