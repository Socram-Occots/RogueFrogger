extends Label

func _ready():
	text = "Highscore: " + str(SettingsDataContainer.get_high_score())
