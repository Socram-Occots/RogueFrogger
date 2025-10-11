extends Control

@onready var audio_l = $HBoxContainer/Audio_L as Label
@onready var h_slider = $HBoxContainer/HSlider as HSlider
@onready var audio_n = $HBoxContainer/Audio_N as Label

@export_enum("Master", "Music", "SFX") var bus_name : String
@export var group : String

var bus_index : int = 0

func _ready():
	h_slider.value_changed.connect(on_value_changed)
	get_bus_name_by_index()
	load_data()
	set_name_label()
	add_to_group(group)
	
func load_data(default : bool = false) -> void:
	match bus_name:
		"Master":
			on_value_changed(SettingsDataContainer.get_master_volume(default))
		"Music":
			on_value_changed(SettingsDataContainer.get_music_volume(default))
		"SFX":
			on_value_changed(SettingsDataContainer.get_sfx_volume(default))
	set_slider_value()
	

func set_name_label() -> void:
	audio_l.text = str(bus_name)

func set_audio_num_label_text() -> void:
	audio_n.text = str(h_slider.value*100)

func on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	set_audio_num_label_text()

func get_bus_name_by_index() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	
func set_slider_value() -> void:
	h_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	set_audio_num_label_text()

func save_value() -> void:
	var saved_val : float = h_slider.value
	match bus_index:
		0:
			SettingsSignalBus.emit_on_master_sound_set(saved_val)
		1:
			SettingsSignalBus.emit_on_music_sound_set(saved_val)
		2:
			SettingsSignalBus.emit_on_sfx_sound_set(saved_val)

func reset_value() -> void:
	load_data(true)
	
