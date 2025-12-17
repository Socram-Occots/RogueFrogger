extends HBoxContainer
@onready var game_mode: Label = $GameMode

func _ready():
	if Global.sandbox:
		game_mode.text = "Sandbox"
	else:
		game_mode.text = "Main"
