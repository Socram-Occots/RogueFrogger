extends VBoxContainer
@onready var highscore: Label = $Highscore
@onready var speedrun_100: Label = $Speedrun100
@onready var speedrun_250: Label = $Speedrun250
@onready var speedrun_500: Label = $Speedrun500
@onready var speedrun_750: Label = $Speedrun750
@onready var speedrun_1000: Label = $Speedrun1000

func _ready():
	highscore.text = "Highscore: " + str(SettingsDataContainer.get_high_score())
	
	var  speedrun_100real : float = SettingsDataContainer.get_speedrun_dict_type("speedrun_100")
	speedrun_100.text = "Speedrun 100: h:%d m:%d s:%.3f" % \
	[speedrun_100real / 3600, speedrun_100real / 60, fmod(speedrun_100real, 60)]
	
	var  speedrun_250real : float = SettingsDataContainer.get_speedrun_dict_type("speedrun_250")
	speedrun_250.text = "Speedrun 250: h:%d m:%d s:%.3f" % \
	[speedrun_250real / 3600, speedrun_250real / 60, fmod(speedrun_250real, 60)]
	
	var  speedrun_500real : float = SettingsDataContainer.get_speedrun_dict_type("speedrun_500")
	speedrun_500.text = "Speedrun 500: h:%d m:%d s:%.3f" % \
	[speedrun_500real / 3600, speedrun_500real / 60, fmod(speedrun_500real, 60)]
	
	var  speedrun_750real : float = SettingsDataContainer.get_speedrun_dict_type("speedrun_750")
	speedrun_750.text = "Speedrun 750: h:%d m:%d s:%.3f" % \
	[speedrun_750real / 3600, speedrun_750real / 60, fmod(speedrun_750real, 60)]
	
	var  speedrun_1000real : float = SettingsDataContainer.get_speedrun_dict_type("speedrun_1000")
	speedrun_1000.text = "Speedrun 1000: h:%d m:%d s:%.3f" % \
	[speedrun_1000real / 3600, speedrun_1000real / 60, fmod(speedrun_1000real, 60)]
