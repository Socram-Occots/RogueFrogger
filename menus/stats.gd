extends VBoxContainer
@onready var highscore: Label = $Highscore
@onready var speedrun_100: Label = $Speedrun100
@onready var speedrun_250: Label = $Speedrun250
@onready var speedrun_500: Label = $Speedrun500
@onready var speedrun_750: Label = $Speedrun750
@onready var speedrun_1000: Label = $Speedrun1000

func _ready():
	highscore.text = "Highscore: " + str(SettingsDataContainer.get_high_score())
	speedrun_100.text = "Speedrun 100: " + str(
		SettingsDataContainer.get_speedrun_dict_type("speedrun_100")).pad_decimals(4)
	speedrun_250.text = "Speedrun 250: " + str(
		SettingsDataContainer.get_speedrun_dict_type("speedrun_250")).pad_decimals(4)
	speedrun_500.text = "Speedrun 500: " + str(
		SettingsDataContainer.get_speedrun_dict_type("speedrun_500")).pad_decimals(4)
	speedrun_750.text = "Speedrun 750: " + str(
		SettingsDataContainer.get_speedrun_dict_type("speedrun_750")).pad_decimals(4)
	speedrun_1000.text = "Speedrun 1000: " + str(
		SettingsDataContainer.get_speedrun_dict_type("speedrun_1000")).pad_decimals(4)
