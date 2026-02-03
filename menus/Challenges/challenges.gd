extends Control
@onready var label: Label = $VBoxContainer/HBoxContainer/Desc/HBoxContainer/Label
@onready var option_button: OptionButton = $VBoxContainer/HBoxContainer/Selections/OptionButton
@onready var chalKeys := SettingsDataContainer.get_challenges_All().keys()
@onready var title: Label = $VBoxContainer/HBoxContainer/Desc/Title
@onready var high_score: Label = $VBoxContainer/HBoxContainer/Desc/HighScore
@onready var play: Button = $VBoxContainer/HBoxContainer2/Play
@onready var exit: Button = $VBoxContainer/HBoxContainer2/Exit
@onready var block: Control = $Block

func _ready() -> void:
	add_to_group("UI_FOCUS", true)
	add_chellenges()
	option_button.select(0)
	_on_option_button_item_selected(0)
	check_unlock()
	begin_focus()

func add_chellenges() -> void:
	for i in chalKeys:
		option_button.add_item(i)

func begin_focus():
	if SettingsDataContainer.get_reached_50_score():
		option_button.grab_focus()
	else:
		exit.grab_focus()

func _on_option_button_item_selected(index: int) -> void:
	title.text = chalKeys[index]
	label.text = SettingsDataContainer.get_challenges_Desc(chalKeys[index])
	set_highscoretext(index)
	
func set_highscoretext(index : int) -> void:
	high_score.text = "High Score: " + str(
		SettingsDataContainer.get_challenges_high_score(chalKeys[index]))

func _on_exit_pressed() -> void:
	Global.back_to_startscreen = true
	get_tree().change_scene_to_file("res://menus/startscreen.tscn")

func _on_play_pressed() -> void:
	Global.challenge = true
	Global.challenge_curr = chalKeys[option_button.selected]
	get_tree().change_scene_to_file("res://Level/level.tscn")

func check_unlock() -> void:
	block.visible = false
	if !SettingsDataContainer.get_reached_50_score():
		if SettingsDataContainer.get_high_score() > 50:
			SettingsSignalBus.emit_on_reached_50_score_set(true)
			SettingsSignalBus.emit_set_settings_dictionary(
				SettingsDataContainer.create_storage_dictionary())
		else:
			disable_challenges()
	
func disable_challenges() -> void:
	option_button.disabled = true
	play.disabled = true
	block.visible = true
