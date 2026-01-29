extends Control

@export var object : String 
@export var max_len : int
@export var group : String
@onready var label: Label = $HBoxContainer/label
@onready var line_edit: LineEdit = $HBoxContainer/Button/LineEdit
@onready var button: Button = $HBoxContainer/Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = object
	line_edit.set_max_length(max_len)
	set_properties()
	add_to_group(group)
	
func set_properties() -> void:
	match object:
		"Seed":
			line_edit.set_placeholder("Set Seed")
			line_edit.set_text(
				SettingsDataContainer.get_sandbox_seed())
		_: print("Object does not exist in LineTextSetter Set: ", object)
	
func save_value() -> void:
	match object:
		"Seed": 
			SettingsSignalBus.emit_on_sandbox_seed_set(
			line_edit.get_text().strip_edges().strip_escapes())
		_: print("Object does not exist in LineTextSetter Save: ", object)
		
func reset_value() -> void:
	match object:
		"Seed": 
			line_edit.set_text(
			SettingsDataContainer.get_sandbox_seed(true))
		_: print("Object does not exist in LineTextSetter Reset: ", object)

func _on_button_pressed() -> void:
	if button.has_focus():
		line_edit.grab_focus.call_deferred()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") && line_edit.has_focus():
		line_edit.clear()
		button.grab_focus.call_deferred()
	elif event.is_action_pressed("ui_accept") && line_edit.has_focus():
		button.grab_focus.call_deferred()
		
