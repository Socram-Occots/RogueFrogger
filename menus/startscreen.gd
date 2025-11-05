extends Control

const OPTIONS : Resource = preload("res://menus/Options/option_menu.tscn")
@onready var start: Button = $Options/Start
@onready var options: Button = $Options/Options
@onready var sandbox: Button = $Options/Sandbox
@onready var credits: Button = $Options/Credits

func loadOptions() -> void:
	var optionspopup : Control = OPTIONS.instantiate()
	optionspopup.visible = false
	$CanvasLayer.add_child(optionspopup)
	Global.options_pop_up = optionspopup

func _ready() -> void:
	Global.sandbox = false
	loadOptions()
	add_to_group("UI_FOCUS", true)
	add_to_group("UI_FOCUS_OPTIONS", true)
	add_to_group("UI_FOCUS_SANDBOX", true)
	add_to_group("UI_FOCUS_CREDITS", true)
	begin_focus() 

func begin_focus() -> void:
	if visible:
		start.grab_focus.call_deferred()
func begin_focus_options() -> void:
	if visible:
		options.grab_focus.call_deferred()
func begin_focus_sandbox() -> void:
	if visible:
		sandbox.grab_focus.call_deferred()
func begin_focus_credits() -> void:
	if visible:
		credits.grab_focus.call_deferred()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Level/level.tscn")

func _on_sandbox_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/sandbox/sandbox_options.tscn")

func _on_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://tutorial/tutorial.tscn")

func _on_options_pressed() -> void:
	Global.options_up()

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/credits.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
