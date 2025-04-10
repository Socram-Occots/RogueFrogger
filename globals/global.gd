extends Node

#verison
var version : String = "V 0.0.0.6"

#score
var score : int = -1

#gamestate
var defeat_var : bool = false

#input
var input_active : bool = false
#var paused = false

#base
#player
const player_base_speed : float = 750
var player_prev_vel : Vector2 = Vector2(0,0)
#car
const car_base_speed : float = 125.0
#dash
const dash_base : float = 1.5 - 0.03
const dash_base_time : float = 0.3
const dash_cool_down_base : float = 2.0
#timer
const timer_base_l : float = 4.2
const timer_base_h : float = 5.4
#grapple
const grapple_cool_down_base : float = 2.0
const grapple_speed_base : float = 500
const grapple_strength_base : float = 500
const grapple_length_base : float = 250
#glide
const glide_cool_down_base : float = 2.0
const glide_base_time : float = 0.5


# playerspeed
var player_speed_mod : float = 0.0
var player_speed_scaling = player_base_speed
#car speed
var car_speed_mod : float = 0.0
var car_speed_scaling = car_base_speed
var prev_car_speed : float = car_base_speed

#dash
var dash : bool = false
var dash_mod : float = 0.0
var dash_scaling = dash_base
var dash_time = dash_base_time
var dash_cool_down = dash_cool_down_base
var dash_cool_down_bool : bool = false

#timer
var timer_mod : int = 0
var timer_l = timer_base_l
var timer_h = timer_base_h

# exploding barrel
var expl_B_mod : int = 0
var expl_B_impulse_mod : float = 1.0
var expl_B_size_mod : float = 1.0
var expl_B_chance_mod : int = 0

#Terrain
var spawnTerrain : bool = false

# player
var player_pos_x : float = 0.0
var player_pos_y : float = 0.0

# player attributes
const player_width_px : int = 46

# shield
#var shield_enabled = false

#postions
const despawn_lower : float = 1600
const despawn_left : float = -200
const despawn_right : float = 2150
const despawn_upper : float = -1600

#itemlabels
var playerspeedlabelon : bool = false
var carspeedlabelon : bool = false
var dashlabelon : bool = false
var expl_B_labelon : bool = false
var grapplelabelon : bool = false
var glidelabelon : bool = false
var updatelabels : bool = false

#global popups
var game_over_pop_up = null
var pause_popup = null
var tutorial_over_pop_up = null
var options_pop_up = null

#grapplerope
var grapple : bool = false
var grapple_cool_down : float = grapple_cool_down_base
var grapple_cool_down_bool : bool = false
var grapple_mod : int = 0
var grapple_speed : float = grapple_speed_base
var grapple_strength : float = grapple_strength_base
var grapple_length : float = grapple_length_base

#glide
var glide : bool = false
var glide_cool_down : float = grapple_cool_down_base
var glide_cool_down_bool : bool = false
var glide_mod : int = 0
var glide_time : float = glide_base_time

func reset() -> void:
	#input
	input_active = false
	#paused = false
	
	#score
	score = -1
	# gamestate
	defeat_var = false
	# playerspeed
	player_prev_vel = Vector2(0,0)
	player_speed_mod = 0
	player_speed_scaling = player_base_speed
	#car speed
	car_speed_mod = 0
	car_speed_scaling = car_base_speed
	prev_car_speed = car_base_speed
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

	# exploding barrel
	expl_B_mod = 0
	expl_B_impulse_mod = 1.0
	expl_B_size_mod = 1.0
	expl_B_chance_mod = 0

	#itemlabels
	playerspeedlabelon = false
	carspeedlabelon = false
	dashlabelon = false
	expl_B_labelon = false
	grapplelabelon = false
	glidelabelon = false
	updatelabels = false
	
	#grapplerope
	grapple = false
	grapple_cool_down = grapple_cool_down_base
	grapple_cool_down_bool = false
	grapple_mod = 0
	grapple_speed = grapple_speed_base
	grapple_strength = grapple_strength_base
	grapple_length = grapple_length_base
	
	#glide
	glide = false
	glide_cool_down = grapple_cool_down_base
	glide_cool_down_bool = false
	glide_mod = 0
	glide_time = glide_base_time
	
func incrementDifficulty(x : int) -> void:
	if score != 0 && score % x == 0:
		car_speed_scaling += 1
		timer_l -= 0.01
		timer_l-= 0.01
		if (timer_l < 1.5):
			timer_l = 1.5
		if (timer_h < 1.5):
			timer_h = 1.5
	
func defeat() -> void:
	get_tree().paused = true
	game_over_pop_up.set_visible(true)
	
func pause() -> void:
	if (game_over_pop_up != null && !game_over_pop_up.visible) &&\
	(tutorial_over_pop_up == null || !tutorial_over_pop_up.visible):
			get_tree().paused = true
			pause_popup.set_visible(true)
		
func unpause() -> void:
		get_tree().paused = false
		pause_popup.set_visible(false)

func tutorialDone() -> void:
	get_tree().paused = true
	tutorial_over_pop_up.set_visible(true)
	
func options_up() -> void:
	if pause_popup != null && pause_popup.visible == true:
		pause_popup.set_process(false)
	elif score == -1:
		get_tree().paused = true
	options_pop_up.set_visible(true)
	
func options_down() -> void:
	if pause_popup != null && pause_popup.visible == true:
		pause_popup.set_process(true)
	elif score == -1:
		get_tree().paused = false
	options_pop_up.set_visible(false)

func float_sum_array(array : Array) -> float:
	var sum : float = 0.0
	for element in array:
		sum += element
	return sum
	
func int_sum_array(array : Array) -> int:
	var sum : int = 0
	for element in array:
		sum += element
	return sum
