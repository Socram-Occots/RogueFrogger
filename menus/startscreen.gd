extends Control

const OPTIONS : Resource = preload("res://menus/Options/option_menu.tscn")
@onready var start: Button = $Options/Start
@onready var sandbox: Button = $Options/Sandbox
@onready var tutorial: Button = $Options/Tutorial
@onready var options: Button = $Options/Options
@onready var credits: Button = $Options/Credits
@onready var quit: Button = $Options/Quit
@onready var logbook: Button = $Options/Logbook
@onready var logbook_notif: Polygon2D = $Options/Logbook/Polygon2D

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
	add_to_group("UI_FOCUS_LOGBOOK", true)
	add_to_group("UI_FOCUS_CREDITS", true)
	add_to_group("UI_FOCUS_STARTSCREEN")
	begin_focus()
	scan_for_logbook()

func become_background():
	if visible:
		start.set_focus_mode(FOCUS_NONE)
		sandbox.set_focus_mode(FOCUS_NONE)
		logbook.set_focus_mode(FOCUS_NONE)
		tutorial.set_focus_mode(FOCUS_NONE)
		options.set_focus_mode(FOCUS_NONE)
		credits.set_focus_mode(FOCUS_NONE)
		quit.set_focus_mode(FOCUS_NONE)

func become_foreground():
	if visible:
		start.set_focus_mode(FOCUS_ALL)
		sandbox.set_focus_mode(FOCUS_ALL)
		logbook.set_focus_mode(FOCUS_ALL)
		tutorial.set_focus_mode(FOCUS_ALL)
		options.set_focus_mode(FOCUS_ALL)
		credits.set_focus_mode(FOCUS_ALL)
		quit.set_focus_mode(FOCUS_ALL)

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
func begin_focus_logbook() -> void:
	if visible:
		logbook.grab_focus.call_deferred()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Level/level.tscn")

func _on_sandbox_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/sandbox/sandbox_options.tscn")

func _on_logbook_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/Logbook/logbook.tscn")

func _on_tutorial_pressed() -> void:
	pass
	#get_tree().change_scene_to_file("res://tutorial/tutorial.tscn")

func _on_options_pressed() -> void:
	Global.options_up()

func _on_credits_pressed() -> void:
	pass
	#get_tree().change_scene_to_file("res://menus/credits.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func scan_for_logbook() -> void:
	var temp : Dictionary = SettingsDataContainer.loaded_data.get("logbook_dict")
	var tempbool : bool = false
	for i in temp.keys():
		for a in temp[i].keys():
			if temp[i][a]["bools"][0] != temp[i][a]["bools"][1]:
				tempbool = true
				break
		if tempbool:
			break
	logbook_notif.visible = tempbool
