extends Node

var score = -1

#base
#player
var player_base_speed = 250
var player_prev_vel = 0
#car
var car_base_speed = 125
#dash
var dash_base = 1.5 - 0.03
var dash_base_time = 0.3
var dash_cool_down_base = 2
#timer
var timer_base_l = 3.2
var timer_base_h = 4.4

# playerspeed
var player_speed_mod = 0
var player_speed_scaling = player_base_speed
#car speed
var car_speed_mod = 0
var car_speed_scaling = car_base_speed
var prev_car_speed = 99999

#dash
var dash = false
var dash_mod = 0
var dash_scaling = dash_base
var dash_time = dash_base_time
var dash_cool_down = dash_cool_down_base
var dash_cool_down_bool = false

#timer
var timer_mod = 0
var timer_l = timer_base_l
var timer_h = timer_base_h

#Terrain
var spawnTerrain = false

# player
var player_pos_x = 0
var player_pos_y = 0

# shield
#var shield_enabled = false

func reset():
	score = -1
	# playerspeed
	player_prev_vel = 0
	player_speed_mod = 0
	player_speed_scaling = player_base_speed
	#car speed
	car_speed_mod = 0
	car_speed_scaling = car_base_speed
	prev_car_speed = 99999
	#timing
	timer_mod = 0
	timer_l = timer_base_l
	timer_h = timer_base_h
	#dash
	dash = false
	dash_mod = 0
	dash_scaling = dash_base
	dash_time = dash_base_time
	dash_cool_down = dash_cool_down_base
	dash_cool_down_bool = false

	#Terrain
	spawnTerrain = false

	# player
	player_pos_x = 0
	player_pos_y = 0
	
	#shield
#	shield_enabled = false

func incrementDifficulty(x):
	if score != 0 && score % x == 0:
		car_speed_scaling += 1
		timer_l -= 0.005
		timer_l-= 0.005
		if (timer_l < 1):
			timer_l = 1
		if (timer_h < 1):
			timer_h = 1
