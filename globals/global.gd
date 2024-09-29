extends Node

#verison
var version = "V 0.0.0.6"

#score
var score = -1

#gamestate
var defeat_var = false

#input
var input_active = false
#var paused = false

#base
#player
const player_base_speed = 250
var player_prev_vel = 0
#car
const car_base_speed = 125
#dash
const dash_base = 1.5 - 0.03
const dash_base_time = 0.3
const dash_cool_down_base = 2
#timer
const timer_base_l = 4.2
const timer_base_h = 5.4

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

#postions
const despawn_lower = 1600
const despawn_left = -200
const despawn_right = 2150
const despawn_upper = -1600

#itemlabels
var playerspeedlabelon = false
var carspeedlabelon = false
var dashlabelon = false
var carspacinglabelon = false
var updatelabels = false

#global popups
var game_over_pop_up = null
var pause_popup = null
var tutorial_over_pop_up = null
var options_pop_up = null

func reset():
	#input
	input_active = false
	#paused = false
	#score
	score = -1
	#gamestate
	defeat_var = false
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

	#itemlabels
	playerspeedlabelon = false
	carspeedlabelon = false
	dashlabelon = false
	carspacinglabelon = false
	updatelabels = false

func incrementDifficulty(x):
	if score != 0 && score % x == 0:
		car_speed_scaling += 1
		timer_l -= 0.01
		timer_l-= 0.01
		if (timer_l < 1.5):
			timer_l = 1.5
		if (timer_h < 1.5):
			timer_h = 1.5
	
func defeat():
	get_tree().paused = true
	game_over_pop_up.set_visible(true)
	
func pause():
	if (game_over_pop_up != null && !game_over_pop_up.visible) &&\
	(tutorial_over_pop_up == null || !tutorial_over_pop_up.visible):
			get_tree().paused = true
			pause_popup.set_visible(true)
		
func unpause():
		get_tree().paused = false
		pause_popup.set_visible(false)

func tutorialDone():
	get_tree().paused = true
	tutorial_over_pop_up.set_visible(true)
	
func options_up():
	if pause_popup != null && pause_popup.visible == true:
		pause_popup.set_process(false)
	elif score == -1:
		get_tree().paused = true
	options_pop_up.set_visible(true)
	
func options_down():
	if pause_popup != null && pause_popup.visible == true:
		pause_popup.set_process(true)
	elif score == -1:
		get_tree().paused = false
	options_pop_up.set_visible(false)

