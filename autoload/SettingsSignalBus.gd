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
signal on_general_sandbox_dict_set(value: Dictionary)
signal on_items_sandbox_dict_set(value: Dictionary)
signal on_multi_sandbox_dict_set(value: Dictionary)
signal on_gamba_sandbox_dict_set(value: Dictionary)
signal on_shop_sandbox_dict_set(value: Dictionary)

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
func emit_on_general_sandbox_dict_set(dict: Dictionary) -> void:
	on_general_sandbox_dict_set.emit(dict)
func emit_on_items_sandbox_dict_set(dict: Dictionary) -> void:
	on_items_sandbox_dict_set.emit(dict)
func emit_on_multi_sandbox_dict_set(dict: Dictionary) -> void:
	on_multi_sandbox_dict_set.emit(dict)
func emit_on_gamba_sandbox_dict_set(dict: Dictionary) -> void:
	on_gamba_sandbox_dict_set.emit(dict)
func emit_on_shop_sandbox_dict_set(dict: Dictionary) -> void:
	on_shop_sandbox_dict_set.emit(dict)
