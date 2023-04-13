extends Node

var score = 0

#base
var player_base_speed = 250
var car_base_speed = 250
var dash_base = 100
var variation_base = 1
var timer_l = 1.6
var timer_h = 2.2
var timer_base = 1

# playerspeed
var player_speed_mod = 1
var player_speed_scaling = 250
#car speed
var car_speed_mod = 1
var car_speed_scaling = 250
#variation and timing
var variation = 1
var variation_scaling = 1
var timer_mod = 1
var timer_scaling = 1
#dash
var dash = false
var dash_mod = 1
var dash_scaling = 100

#Terrain
var spawnTerrain = false

func reset():
	score = 0
	player_speed_mod = 1
	player_speed_scaling = 250
	car_speed_mod = 1
	car_speed_scaling = 250
	dash = false
	dash_mod = 1
	dash_scaling = 100
	player_base_speed = 250
	car_base_speed = 250
	dash_base = 100
	variation_base = 1
	variation = 1
	variation_scaling = 1
	timer_mod = 1
	timer_scaling = 1
	timer_l = 1.6
	timer_h = 2.2
	timer_base = 1

func incrementDifficulty():
	if score != 0:
		car_speed_scaling *= 1.075
		if (variation_scaling > 1):
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
