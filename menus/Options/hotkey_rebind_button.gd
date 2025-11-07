class_name HotkeyRebindButton
extends Control

@onready var label = $HBoxContainer/Label as Label
@onready var button = $HBoxContainer/Button as Button
@onready var curr_bind = null
@onready var cont_icon : ControllerIconTexture = ControllerIconTexture.new()

@export var temp : InputEventJoypadButton
@export var temp2 : InputEventJoypadMotion

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

func map_inputevent_cont_icon(event: InputEvent) -> Array[String]:
	var def : String = ""
	var return_arr : Array[String] = [def, def]
	if event is InputEventKey:
		return return_arr
	elif event is InputEventJoypadButton:
		match event.button_index:
			0: return_arr[0] = "positional/south"
			1: return_arr[0] = "positional/east"
			2: return_arr[0] = "positional/west"
			3: return_arr[0] = "positional/north"
			4: return_arr[0] = "joypad/select"
			5: return_arr[0] = "joypad/home"
			6: return_arr[0] = "joypad/start"
			7: return_arr[0] = "joypad/l_stick_click"
			8: return_arr[0] = "joypad/r_stick_click"
			9: return_arr[0] = "joypad/lb"
			10: return_arr[0] = "joypad/rb"
			11: return_arr[0] = "joypad/dpad_up"
			12: return_arr[0] = "joypad/dpad_down"
			13: return_arr[0] = "joypad/dpad_left"
			14: return_arr[0] = "joypad/dpad_right"
			15: return_arr[0] = "joypad/share"
			_: return_arr[0] = def
	elif event is InputEventJoypadMotion:
		match event.axis:
			0, 1: return_arr[0] = "joypad/l_stick"
			2, 3: return_arr[0] = "joypad/r_stick"
			_: return_arr[0] = def
		if event.axis == 1 || event.axis == 3:
			if event.axis_value < 0: return_arr[1] = "Up"
			elif event.axis_value > 0: return_arr[1] = "Down"
			else: return_arr[1] = "Undef"
		elif event.axis == 0 || event.axis == 2:
			if event.axis_value < 0: return_arr[1] = "left"
			elif event.axis_value > 0: return_arr[1] = "Right"
			else: return_arr[1] = "Undef"
		else: return_arr[1] = "Undef"
	else: return_arr[0] = def
	
	return return_arr

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
		_: print("Falied to find the action_name: ", action_name)

func set_text_for_key() -> void:
	var action_events : Array[InputEvent] = InputMap.action_get_events(action_name)
	if action_events.size() > 0:
		var action_event : InputEvent = action_events[0]
		var action_keycode : String
		if input_type == "keyboard":
			action_keycode = str(OS.get_keycode_string(action_event.physical_keycode))
			button.icon = null
		else:
			var icon_str_arr : Array[String] = map_inputevent_cont_icon(action_event)
			cont_icon.path = icon_str_arr[0]
			action_keycode = icon_str_arr[1]
			button.icon = cont_icon
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
