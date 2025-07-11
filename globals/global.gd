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

#region Base Values
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
#gamba
const gamba_result_sec_base : float = 2.0
const gamba_mod_base : int = 1
#follower
const follower_mod_base : int = 1
const follower_spawn_multi_base : int = 1
#endregion

#region Values
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

#gamba
var gamba_result_sec : float = gamba_result_sec_base
var gamba_update : bool = false
var gamba_running : bool = false
var gamba_mod : int = gamba_mod_base
var gamba_done : bool = false

#follower
var follower_array : Array[RigidBody2D] = []
var follower_mod : int = follower_mod_base
var spawn_follower_bool : bool = false
var followerlabelon : bool = false
var follower_spawn_multi = follower_spawn_multi_base
var Follower = false
#endregion

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
	followerlabelon = false
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
	
	#gamba
	gamba_result_sec = gamba_result_sec_base
	gamba_update = false
	gamba_running = false
	gamba_mod = gamba_mod_base
	gamba_done = false
	
	# follower
	follower_array.clear()
	follower_mod = follower_mod_base
	spawn_follower_bool = false
	follower_spawn_multi = follower_spawn_multi_base
	Follower = false

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

func inc_PlayerSpeed(times : int) -> void:
	if player_speed_mod == 0:
		playerspeedlabelon = true
	player_speed_mod += times
	player_speed_scaling += 20 * times
	updatelabels = true

func inc_GlideBoots(times : int) -> void:
	if glide_mod == 0:
		glidelabelon = true
		glide = true
	glide_mod += times
	glide_cool_down *= (1/1.005) * times
	glide_time += 0.025 * times
	updatelabels = true
	
func inc_Dash(times : int) -> void:
	if !dash:
		dashlabelon = true
		dash = true
	dash_mod += times
	dash_scaling += 0.02 * times
	dash_time = Global.dash_base_time/(Global.dash_scaling/Global.dash_base)
	dash_cool_down *= (1/1.005) * times
	updatelabels = true
	
func inc_expl_B(times : int) -> void:
	if expl_B_mod == 0:
		expl_B_labelon = true
	expl_B_mod += times
	expl_B_impulse_mod += 0.02 * times
	expl_B_size_mod += 0.02 * times
	expl_B_chance_mod += times
	updatelabels = true

func inc_GrappleRope(times : int) -> void:
	if grapple_mod == 0:
		grapple = true
		grapplelabelon = true
	grapple_mod += times
	grapple_speed += 5 * times
	grapple_strength += 25 * times
	grapple_length += 5 * times
	grapple_cool_down *= (1/1.005) * times
	updatelabels = true

func inc_Follower(times : int) -> void:
	if follower_mod == 1:
		followerlabelon = true
	spawn_follower_bool = true
	follower_mod += times
	follower_spawn_multi = times
	Follower = true
	updatelabels = true

func wipe_null_followers() -> void:
	var temp_array : Array[int] = []
	for i in range(0, len(follower_array)):
		if !is_instance_valid(i):
			temp_array.append(i)
	for i in temp_array:
		follower_array.remove_at(i)
