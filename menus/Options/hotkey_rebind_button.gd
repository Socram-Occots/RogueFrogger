class_name HotkeyRebindButton
extends Control

@onready var label = $HBoxContainer/Label as Label
@onready var button = $HBoxContainer/Button as Button
@onready var curr_bind = null

@export var action_name : String = ""
@export var group : String
@export var input_type : String

func _ready():
	set_process_unhandled_input(false)
	set_action_name()
	set_text_for_key()
	load_keybinds()
	add_to_group(group)

func load_keybinds() -> void:
	rebind_action_key(SettingsDataContainer.get_keybind(action_name))

func set_action_name() -> void:
	label.text = "Unassigned"
	
	match action_name:
		"up_w":
			label.text = "Go Up"
		"down_s":
			label.text = "Go Down"
		"right_d":
			label.text = "Go Right"
		"left_a":
			label.text = "Go Left"
		"dash":
			label.text = "Dash"
		"walk":
			label.text = "Slow Down"
		"rope":
			label.text = "Grapple"
		"glide":
			label.text = "Glide"
		"up_cont_stick":
			label.text = "Go Up (Stick)"
		"down_cont_stick":
			label.text = "Go Down (Stick)"
		"right_cont_stick":
			label.text = "Go Right (Stick)"
		"left_cont_stick":
			label.text = "Go Left (Stick)"
		"up_cont_button":
			label.text = "Go Up (Button)"
		"down_cont_button":
			label.text = "Go Down (Button)"
		"right_cont_button":
			label.text = "Go Right (Button)"
		"left_cont_button":
			label.text = "Go Left (Button)"
		"dash_cont":
			label.text = "Dash"
		"walk_cont":
			label.text = "Slow Down"
		"rope_cont":
			label.text = "Grapple"
		"glide_cont":
			label.text = "Glide"
		"up_cont_aim":
			label.text = "Aim Up"
		"down_cont_aim":
			label.text = "Aim Down"
		"right_cont_aim":
			label.text = "Aim Right"
		"left_cont_aim":
			label.text = "Aim Left"

func set_text_for_key() -> void:
	var action_events = InputMap.action_get_events(action_name)
	if action_events.size() > 0:
		var action_event = action_events[0]
		var action_keycode : String 
		match input_type:
			"keyboard":
				action_keycode = str(OS.get_keycode_string(action_event.physical_keycode))
			"analog":
				action_keycode = str(action_events)
			"button":
				action_keycode = str(action_events)
			"cont_flex":
				action_keycode = str(action_events)
		button.text = action_keycode
	else:
		button.text = "Not assigned"

func _on_button_toggled(toggled_on):
	if toggled_on:
		button.text = "Press any key..."
		set_process_unhandled_input(true)
		
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = false
				i.set_process_unhandled_input(false)
	else:
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			#if i.action_name != self.action_name:
			i.button.toggle_mode = true
			i.set_process_unhandled_input(false)
		
		set_text_for_key()

func _unhandled_input(event: InputEvent) -> void:
	var welcome_key : bool = false
	match input_type:
		"keyboard":
			welcome_key = event is InputEventKey && event.pressed && not event.echo
		"analog":
			welcome_key = event is InputEventJoypadMotion && \
			abs(event.axis_value) > 0.3
		"button":
			welcome_key = event is InputEventJoypadButton && event.pressed
		"cont_flex":
			welcome_key = (event is InputEventJoypadMotion && abs(event.axis_value) > 0.3) \
			|| (event is InputEventJoypadButton && event.pressed)
	if welcome_key:
		rebind_action_key(event)
		button.set_pressed_no_signal(false)
	
func rebind_action_key(event) -> void:
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name, event)
	
	curr_bind = event
	
	set_process_unhandled_input(false)
	set_text_for_key()
	reset_buttons()
	

func reset_buttons():
	for i in get_tree().get_nodes_in_group("hotkey_button"):
		if i.button:
			i.button.toggle_mode = true
			i.set_process_unhandled_input(false)

func _on_button_focus_exited() -> void:
	pass

func save_value() -> void:
	SettingsDataContainer.set_keybind(action_name, curr_bind)

func reset_value() -> void:
	var reset_event = SettingsDataContainer.get_keybind(action_name, true)
	rebind_action_key(reset_event)
