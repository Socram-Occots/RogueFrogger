extends Node

@onready var maprand : RandomNumberGenerator = RandomNumberGenerator.new()
@onready var itemrand : RandomNumberGenerator = RandomNumberGenerator.new()

func shuffle_array(shuff_arr: Array, RNGint : int = 0) -> Array:
	var n : int = shuff_arr.size()
	var RNG : RandomNumberGenerator
	match RNGint:
		0: RNG = maprand
		1: RNG = itemrand
		_: RNG = maprand

	for i in range(0, n):
		var j = RNG.randi_range(0, n - 1)
		
		var temp = shuff_arr[i]
		shuff_arr[i] = shuff_arr[j]
		shuff_arr[j] = temp
	return shuff_arr
