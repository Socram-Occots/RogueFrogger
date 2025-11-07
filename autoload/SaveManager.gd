extends Node

const SETTINGS_SAVE_PATH : String = "user://SettingData.save"
const SECTION : String = "SettingData"

var settings_data_dict : Dictionary = {}

func _ready():
	SettingsSignalBus.set_settings_dictionary.connect(on_settings_save)
	load_settings_data()

func on_settings_save(data: Dictionary) -> void:
	var config_file : ConfigFile = ConfigFile.new()
	# all keys should be a String value
	for k in data:
		config_file.set_value(SECTION, k, data[k])
		
	var error = config_file.save_encrypted_pass(SETTINGS_SAVE_PATH, "Sugma")
	if error != OK:
		print("SettingData has failed on save: ", error)

func load_settings_data() -> void:
	if not FileAccess.file_exists(SETTINGS_SAVE_PATH):
		SettingsSignalBus.emit_load_settings_data({})
		SettingsSignalBus.emit_set_settings_dictionary(SettingsDataContainer.create_storage_dictionary())
		return
	var config_file = ConfigFile.new()
	var loaded_data : Dictionary = {}
	var error = config_file.load_encrypted_pass(SETTINGS_SAVE_PATH, "Sugma")
	if error != OK:
		print("SettingData has failed on load: ", error)
		return
		
	for k in config_file.get_section_keys(SECTION):
		loaded_data[k] = config_file.get_value(SECTION, k)
	
	SettingsSignalBus.emit_load_settings_data(loaded_data)
