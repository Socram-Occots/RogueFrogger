extends Control

const OPTIONS : Resource = preload("res://menus/Options/option_menu.tscn")

func loadOptions():
	var optionspopup : Control = OPTIONS.instantiate().duplicate()
	optionspopup.visible = false
	$CanvasLayer.add_child(optionspopup)
	Global.options_pop_up = optionspopup

func _ready():
	loadOptions()

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Level/level.tscn")


func _on_tutorial_pressed():
	get_tree().change_scene_to_file("res://tutorial/tutorial.tscn")


func _on_options_pressed():
	Global.options_up()

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://menus/credits.tscn")


func _on_quit_pressed():
	get_tree().quit()
