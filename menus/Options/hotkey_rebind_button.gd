class_name HotkeyRebindButton
extends Control

@onready var label = $HBoxContainer/Label as Label
@onready var button = $HBoxContainer/Button as Button

@export var action_name : String = ""

func _ready():
	set_process_unhandled_key_input(false)
	set_action_name()
	set_text_for_key()
	load_keybinds()

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

func set_text_for_key() -> void:
	var action_events = InputMap.action_get_events(action_name)
	if action_events.size() > 0:
		var action_event = action_events[0]
		var action_keycode = OS.get_keycode_string(action_event.physical_keycode)
		button.text = "%s" % action_keycode
	else:
		button.text = "No key assigned"

func _on_button_toggled(toggled_on):
	if toggled_on:
		button.text = "Press any key..."
		set_process_unhandled_key_input(true)
		
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = false
				i.set_process_unhandled_key_input(false)
	else:
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = true
				i.set_process_unhandled_key_input(false)
				
		set_text_for_key()

func _unhandled_key_input(event):
	if event is InputEventKey and event.pressed and not event.echo:
		rebind_action_key(event)
		button.set_pressed_no_signal(false)
	
func rebind_action_key(event) -> void:
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name, event)
	
	SettingsDataContainer.set_keybind(action_name, event)
	
	set_process_unhandled_key_input(false)
	set_text_for_key()
	set_action_name()
	reset_buttons()
	

func reset_buttons():
	for i in get_tree().get_nodes_in_group("hotkey_button"):
		if i.button:
			i.button.toggle_mode = true
			i.set_process_unhandled_key_input(false)

func _on_button_focus_exited() -> void:
	pass
