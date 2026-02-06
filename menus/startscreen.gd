extends Control

const OPTIONS : Resource = preload("res://menus/Options/option_menu.tscn")
@onready var start: Button = $Options/Start
@onready var sandbox: Button = $Options/Sandbox
@onready var options: Button = $Options/Options
@onready var credits: Button = $Options/Credits
@onready var quit: Button = $Options/Quit
@onready var logbook: Button = $Options/Logbook
@onready var logbook_notif: Polygon2D = $Options/Logbook/Polygon2D
@onready var challenges: Button = $Options/Challenges
@onready var challenge_notif: Polygon2D = $Options/Challenges/Polygon2D

func loadOptions() -> void:
	var optionspopup : Control = OPTIONS.instantiate()
	optionspopup.visible = false
	$CanvasLayer.add_child(optionspopup)
	Global.options_pop_up = optionspopup

func _ready() -> void:
	Global.sandbox = false
	Global.challenge = false
	SettingsSignalBus.emit_on_logbook_dict_set("Objects", "Cars", true, 0)
	SettingsSignalBus.emit_on_logbook_dict_set("Objects", "LineOfDeath", true, 0)
	loadOptions()
	Global.back_to_startscreen = false
	add_to_group("UI_FOCUS", true)
	add_to_group("UI_FOCUS_OPTIONS", true)
	add_to_group("UI_FOCUS_SANDBOX", true)
	add_to_group("UI_FOCUS_LOGBOOK", true)
	add_to_group("UI_FOCUS_CHALLENGES", true)
	add_to_group("UI_FOCUS_CREDITS", true)
	add_to_group("UI_FOCUS_STARTSCREEN")
	begin_focus()
	scan_for_logbook()
	check_challenge_unlock()

func become_background():
	if visible:
		start.set_focus_mode(FOCUS_NONE)
		sandbox.set_focus_mode(FOCUS_NONE)
		logbook.set_focus_mode(FOCUS_NONE)
		challenges.set_focus_mode(FOCUS_NONE)
		options.set_focus_mode(FOCUS_NONE)
		credits.set_focus_mode(FOCUS_NONE)
		quit.set_focus_mode(FOCUS_NONE)

func become_foreground():
	if visible:
		start.set_focus_mode(FOCUS_ALL)
		sandbox.set_focus_mode(FOCUS_ALL)
		logbook.set_focus_mode(FOCUS_ALL)
		challenges.set_focus_mode(FOCUS_ALL)
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
func begin_focus_challenges() -> void:
	if visible:
		challenges.grab_focus.call_deferred()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Level/level.tscn")

func _on_sandbox_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/sandbox/sandbox_options.tscn")

func _on_logbook_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/Logbook/logbook.tscn")

func _on_challenges_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/Challenges/challenges.tscn")

func _on_options_pressed() -> void:
	Global.options_up()

func _on_credits_pressed() -> void:
	pass
	#get_tree().change_scene_to_file("res://menus/credits.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func scan_for_logbook() -> void:
	var temp : Dictionary = SettingsDataContainer.loaded_data.get("logbook_dict")
	# stoping invisible object stats from falsely flagging the logbook
	SettingsDataContainer.on_logbook_dict_set(
		"Objects", "ExplBarrelPickUpEvent", 
		SettingsDataContainer.get_logbook_dict(
			"Objects", "ExplBarrelPickUpEvent")[0], 
			1)
		
	var tempbool : bool = false
	for i in temp.keys():
		for a in temp[i].keys():
			if temp[i][a]["bools"][0] != temp[i][a]["bools"][1]:
				tempbool = true
				break
		if tempbool: break
	logbook_notif.visible = tempbool

func check_challenge_unlock() -> void:
	if SettingsDataContainer.get_high_score() > 50:
		challenge_notif.visible = !SettingsDataContainer.get_reached_50_score()
	else:
		challenge_notif.visible = false
