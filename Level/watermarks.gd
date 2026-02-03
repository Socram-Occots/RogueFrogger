extends HBoxContainer
@onready var game_mode: Label = $GameMode

func _ready():
	if Global.sandbox:
		game_mode.text = "Sandbox"
	elif Global.challenge:
		game_mode.text = "Challenge " + str(Global.challenge_curr)
	else:
		game_mode.text = "Main"
