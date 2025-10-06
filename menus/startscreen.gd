extends Control

const OPTIONS : Resource = preload("res://menus/Options/option_menu.tscn")

func loadOptions() -> void:
	var optionspopup : Control = OPTIONS.instantiate()
	optionspopup.visible = false
	$CanvasLayer.add_child(optionspopup)
	Global.options_pop_up = optionspopup

func _ready() -> void:
	loadOptions()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Level/level.tscn")

func _on_sandbox_pressed() -> void:
	pass # Replace with function body.

func _on_tutorial_pressed() -> void:
	get_tree().change_scene_to_file("res://tutorial/tutorial.tscn")

func _on_options_pressed() -> void:
	Global.options_up()

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/credits.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
