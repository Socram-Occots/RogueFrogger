extends Node

# settings
signal on_window_mode_selected(index: int)
signal on_resolution_selected(index: int)
signal on_aspect_selected(index: int)
signal on_master_sound_set(value: float)
signal on_music_sound_set(value: float)
signal on_sfx_sound_set(value: float)
# game data
signal on_high_score_set(value: int)
# sandbox data
signal on_sandbox_dict_set(type: String, object: String, num: int)
signal on_sandbox_dict_setAll(dict: Dictionary)
signal on_sandbox_seed_set(value: String)
# aim toggle
signal on_mouse_aim_toggle_set(value: bool)
signal on_controller_aim_toggle_set(value: bool)

signal set_settings_dictionary(settings_dict : Dictionary)

signal load_settings_data(settings_dict : Dictionary)

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
# game data
func emit_on_high_score_set(value: int) -> void:
	on_high_score_set.emit(value)
# sandbox data
func emit_on_sandbox_dict_set(type: String, object: String, num: int) -> void:
	on_sandbox_dict_set.emit(type, object, num)
func emit_on_sandbox_dict_setAll(dict : Dictionary) -> void:
	on_sandbox_dict_setAll.emit(dict)
func emit_on_sandbox_seed_set(value: String) -> void:
	on_sandbox_seed_set.emit(value)
func emit_on_mouse_aim_toggle_set(value: bool) -> void:
	on_mouse_aim_toggle_set.emit(value)
func emit_on_controller_aim_toggle_set(value: bool) -> void:
	on_controller_aim_toggle_set.emit(value)
