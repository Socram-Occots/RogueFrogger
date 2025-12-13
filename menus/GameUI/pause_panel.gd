extends Control


#@onready paused = false
@onready var seedy: Label = $CenterContainer/ColorRect/VBoxContainer/Seed
@onready var score: Label = $CenterContainer/ColorRect/VBoxContainer/Score
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sandbox_seed : String = SettingsDataContainer.get_sandbox_seed(!Global.sandbox)
@onready var retry: Button = $CenterContainer/ColorRect/VBoxContainer/HBoxContainer/retry
@onready var resume: Button = $CenterContainer/ColorRect/VBoxContainer/HBoxContainer/resume
@onready var label: Label = $VBoxContainer/HBoxContainer/Label
@onready var tooltiptexturerect : TextureRect = $VBoxContainer/VBoxContainer2/HBoxContainer/TextureRect
@onready var tooltipcontainer : HBoxContainer = $VBoxContainer/VBoxContainer2/HBoxContainer
@onready var label_tooltip: Label = $VBoxContainer/VBoxContainer2/Label

func _ready():
	add_to_group("UI_FOCUS", true)
	label.visible = false
	label_tooltip.visible = false

func load_itemtooltips() -> void:
	var items : Array[Node] = get_tree().root.get_node(
		"Level/CanvasLayer/HBoxContainer").get_children()
	for i in items:
		label_tooltip.visible = true
		var temp : TextureRect = tooltiptexturerect.duplicate()
		temp.visible = true
		temp.itemtip = SettingsDataContainer.get_logbook_dict_tooltip(i.get_meta("Nature"), i.get_meta("ItemType"))
		#Global.TOOLTIPS.ITEMTOOLTIPDICTIONARY[i.get_meta("ItemType")]
		temp.texture = i.get_node("Sprite2D").texture
		tooltipcontainer.add_child(temp)

func begin_focus() -> void:
	if visible:
		resume.grab_focus.call_deferred()

func show_seed() -> void:
	if Global.sandbox && sandbox_seed:
		seedy.set_text("Seed: " + sandbox_seed)
	else:
		seedy.set_text("Seed: " + str(GRand.maprand.get_seed()))

func _on_visibility_changed():
	if visible:
		score.text = "Score: " + str(Global.score)
		animation_player.play("startpause")
		show_seed()
		begin_focus()
		load_itemtooltips()
	elif tooltipcontainer:
		for i in tooltipcontainer.get_children():
			if i.visible:
				i.queue_free()

func _on_retry_pressed():
	Global.reset()
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_menu_pressed():
	Global.reset()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menus/startscreen.tscn")
	
func _on_quit_pressed():
	get_tree().quit()

func _on_resume_pressed() -> void:
	if visible:
		Global.unpause()

func _input(event):
	if event.is_action_pressed("ui_pause"):
		if visible:
			Global.unpause()
		elif !visible:
			Global.pause()

func _on_resume_focus_entered() -> void:
	label.visible = false
