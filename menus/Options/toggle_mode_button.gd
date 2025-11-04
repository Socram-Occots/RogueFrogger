extends Control

@export var t_name : String
@export var group : String
@onready var mode : bool = false
@onready var label : Label = $HBoxContainer/Label
@onready var check_button : CheckButton = $HBoxContainer/CheckButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	check_button.toggled.connect(on_toggle_selected)
	add_to_group(group)
	load_data()

func on_toggle_selected(toggled_on : bool) -> void:
	if toggled_on:
		check_button.text = "On"
	else:
		check_button.text = "Off"
	mode = toggled_on

func set_toggle_text() -> void:
	match t_name:
		"mouse_aim":
			label.text = "Aim with Mouse"
		"controller_aim":
			label.text = "Aim with Stick"
		_: print("Failed to set toggle name: ", t_name)

func save_value() -> void:
	match t_name:
		"mouse_aim":
			SettingsSignalBus.emit_on_mouse_aim_toggle_set(mode)
		"controller_aim":
			SettingsSignalBus.emit_on_controller_aim_toggle_set(mode)
		_: print("Failed to save toggle value: ", t_name)

func set_state() -> void:
	check_button.button_pressed = mode

func reset_value() -> void:
	load_data(true)

func load_data(default : bool = false) -> void:
	match t_name:
		"mouse_aim":
			on_toggle_selected(
				SettingsDataContainer.get_mouse_aim_toggle(default))
		"controller_aim":
			on_toggle_selected(
				SettingsDataContainer.get_controller_aim_toggle(default))
		_: print("Failed to load_ data: ", t_name)
	set_state()
