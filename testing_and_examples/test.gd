extends Node2D

@onready var DEFAULT_SETTINGS : DefaultSettingsResource = preload("res://autoload/DefaultSettings.tres")

var DEF_ARR : Array[Array] = [[["str1"]], 
["Str2"]]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(DEFAULT_SETTINGS.default_general_sandbox_dict.keys())
	print(DEFAULT_SETTINGS.default_general_sandbox_dict.values())
	print(DEFAULT_SETTINGS.default_items_sandbox_dict.keys())
	print(DEFAULT_SETTINGS.default_items_sandbox_dict.values())
	print(DEFAULT_SETTINGS.default_multi_sandbox_dict.keys())
	print(DEFAULT_SETTINGS.default_multi_sandbox_dict.values())
	print(DEFAULT_SETTINGS.default_gamba_sandbox_dict.keys())
	print(DEFAULT_SETTINGS.default_gamba_sandbox_dict.values())
	print(DEFAULT_SETTINGS.default_shop_sandbox_dict.keys())
	print(DEFAULT_SETTINGS.default_shop_sandbox_dict.values())

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
