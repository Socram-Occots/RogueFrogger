extends Node2D

@onready var DEFAULT_SETTINGS : DefaultSettingsResource = preload("res://autoload/DefaultSettings.tres")

var DEF_ARR : Array[Array] = [[["str1"]], 
["Str2"]]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rand = RandomNumberGenerator.new()
	print(rand.seed)
	rand.randomize()
	print(rand.seed)
	rand.seed = 1
	print(rand.seed)
	var arr = ["1","2","3","4"]
	var grr = [1,2,3,4]
	print(arr[rand.rand_weighted(grr)])
	print(randi())
	print(rand.randi())
# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass

func test_array(arr : Array[Array] = DEF_ARR) -> void:
	var temp_arr = arr.duplicate(true)
	print("DEF_ARR",DEF_ARR)
	print("arr",DEF_ARR)
	print("temp_arr", temp_arr)
	temp_arr[0][0].remove_at(0)
	print("DEF_ARR", DEF_ARR)
	print("arr",DEF_ARR)
	print("temp_arr", temp_arr)
