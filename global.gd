extends Node

var score = 0

#base
var player_base_speed = 250
var car_base_speed = 125
var dash_base = 2
var dash_base_time = 0.5
var variation_base = 1
var timer_l = 3.2
var timer_h = 4.4
var timer_base = 1

# playerspeed
var player_speed_mod = 1
var player_speed_scaling = player_base_speed
#car speed
var car_speed_mod = 1
var car_speed_scaling = car_base_speed
var prev_car_speed = 99999
#variation and timing
var variation = variation_base
var variation_scaling = variation_base
var timer_mod = timer_base
var timer_scaling = timer_base
#dash
var dash = false
var dash_mod = 1
var dash_scaling = dash_base
var dash_time = dash_base_time

#Terrain
var spawnTerrain = false

# player
var player_pos_x = 0
var player_pos_y = 0

func reset():
	score = 0
	# playerspeed
	player_speed_mod = 1
	player_speed_scaling = player_base_speed
	#car speed
	car_speed_mod = 1
	car_speed_scaling = car_base_speed
	prev_car_speed = 99999
	#variation and timing
	variation = variation_base
	variation_scaling = variation_base
	timer_mod = timer_base
	timer_scaling = timer_base
	#dash
	dash = false
	dash_mod = 1
	dash_scaling = dash_base
	dash_time = dash_base_time

	#Terrain
	spawnTerrain = false

	# player
	player_pos_x = 0
	player_pos_y = 0

func incrementDifficulty():
	if score != 0:
		car_speed_scaling *= 1.075
		if variation_scaling > 1:
			variation_scaling /= 1.05
		else:
			variation_scaling = 1
		var antitimer = 0.05*(log(score + 1) / log(20)) + timer_base
		timer_l /= antitimer
		timer_h /= antitimer
		if (timer_l < 0.5):
			timer_l = 0.5
		if (timer_h < 0.5):
			timer_h = 0.5
