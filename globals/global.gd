extends Node

#verison
var version : String = "V 0.0.0.6"

#score
var score : int = 0

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
#shrink
const shrink_percent_base : float = 0.5
const shrink_mod_limit_base : int = 100
#slow
const playerslow_percent_base : float = 0.01
const playerslow_mod_base : int = 1
const playerslow_mod_limit_base : int = 99
#grow
const grow_percent_base : float = 0.5
const grow_mod_limit_base : int = 100
# tele
const longtele_cool_down_base : float = 0.5
const shortele_cool_down_base : float = 120
#endregion

#region Values
#tiles
var tiles_spawned : int = 0
var race_condition_tiles : Array[int] = []
var finish_line_tile : Node2D = null

# playerspeed
var player_speed_mod : int = 0
var player_speed_scaling = player_base_speed
#car speed
var car_speed_mod : float = 0.0
var car_speed_scaling = car_base_speed
var prev_car_speed : float = car_base_speed

#dash
var dash : bool = false
var dash_mod : int = 0
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
const player_width_px : int = 48

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

#shrink
var shrink_mod : int = 0
var shrink_mod_real : int = shrink_mod
var shrink_percent : float = shrink_percent_base
var shrink_mod_limit : int = shrink_mod_limit_base
var shrinklabelon : bool = false

#slow
var playerslow_percent : float = playerslow_percent_base
var playerslow_mod : int = playerslow_mod_base
var playerslow_mod_real : int = playerslow_mod_base
var playerslowlabelon : bool = false
var playerslow_mod_limit : int = playerslow_mod_limit_base

#grow
var grow_mod : int = 0
var grow_mod_real : int = grow_mod
var grow_percent: float = grow_percent_base
var grow_mod_limit : int = grow_mod_limit_base
var growlabelon : bool = false

#line
var game_line : Node2D = null

# tele
var longtele_mod : int = 0
var shorttele_mod : int = 0
var longtele_cool_down : float = longtele_cool_down_base
var shortele_cool_down : float = shortele_cool_down_base
var longtelelabelon : bool = false
var shorttelelabelon : bool = false
#endregion

func reset() -> void:
	#tiles
	tiles_spawned = 0
	race_condition_tiles = []
	finish_line_tile = null
	
	#input
	input_active = false
	#paused = false
	
	#score
	score = 0
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
	shrinklabelon = false
	playerslowlabelon = false
	growlabelon = false
	longtelelabelon = false
	shorttelelabelon = false
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
	
	#shrink
	shrink_mod = 0
	shrink_mod_real = shrink_mod
	shrink_percent = shrink_percent_base
	shrink_mod_limit = shrink_mod_limit_base
	
	#slow
	playerslow_percent = playerslow_mod_base
	playerslow_mod = playerslow_mod_base
	playerslow_mod_real = playerslow_mod_base
	playerslow_mod_limit = playerslow_mod_limit_base
	
	#grow
	grow_mod = 0
	grow_mod_real = grow_mod
	grow_percent = grow_percent_base
	grow_mod_limit = grow_mod_limit_base
	
	#line
	game_line = null
	
	# tele
	longtele_mod = 0
	shorttele_mod = 0
	longtele_cool_down = longtele_cool_down_base
	shortele_cool_down = shortele_cool_down_base

func incrementDifficulty(x : int = 2, int_multiple : int = 1) -> void:
	if score != 0 && score % x == 0:
		car_speed_scaling += 1 * int_multiple
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
	if player_speed_mod == 0:
		playerspeedlabelon = true
	player_speed_scaling += 20 * times
	updatelabels = true

func inc_GlideBoots(times : int) -> void:
	if glide_mod == 0:
		glide = true
		glidelabelon = true
	glide_mod += times
	if glide_mod == 0:
		glide = false
		glidelabelon = true
	glide_cool_down = glide_cool_down_base * ((1/1.005) ** glide_mod)
	glide_time += 0.025 * times
	updatelabels = true
	
func inc_Dash(times : int) -> void:
	if dash_mod == 0:
		dashlabelon = true
		dash = true
	dash_mod += times
	if dash_mod == 0:
		dash = false
		dashlabelon = true
	dash_scaling += 0.02 * times
	dash_time = Global.dash_base_time/(Global.dash_scaling/Global.dash_base)
	dash_cool_down = dash_cool_down_base * ((1/1.005) ** dash_mod)
	updatelabels = true
	
func inc_expl_B(times : int) -> void:
	if expl_B_mod == 0:
		expl_B_labelon = true
	expl_B_mod += times
	if expl_B_mod == 0:
		expl_B_labelon = true
	expl_B_impulse_mod += 0.02 * times
	expl_B_size_mod += 0.02 * times
	expl_B_chance_mod += times
	updatelabels = true

func inc_GrappleRope(times : int) -> void:
	if grapple_mod == 0:
		grapple = true
		grapplelabelon = true
	grapple_mod += times
	if grapple_mod == 0:
		grapple = false
		grapplelabelon = true
	grapple_speed += 5 * times
	grapple_strength += 25 * times
	grapple_length += 5 * times
	grapple_cool_down = grapple_cool_down_base * ((1/1.005) ** grapple_mod)
	updatelabels = true

func inc_Follower(times : int) -> void:
	if follower_mod == 1:
		followerlabelon = true
	spawn_follower_bool = true
	follower_mod += times
	follower_spawn_multi = times
	Follower = true
	updatelabels = true

func inc_Shrink(times : int) -> void:
	if shrink_mod == 0:
		shrinklabelon = true
	shrink_mod += times
	if shrink_mod == 0:
		shrinklabelon = true
	if shrink_mod < shrink_mod_limit:
		shrink_mod_real = shrink_mod
	else:
		shrink_mod_real = shrink_mod_limit
		
	if !follower_array.is_empty():
		change_player_follower_size()
		
	updatelabels = true

func inc_Gamba(times : int) -> void:
	if gamba_running:
		gamba_mod += times
	elif !(gamba_update || gamba_done):
		gamba_mod += times - 1
		gamba_update = true

func wipe_null_followers() -> void:
	var temp_array : Array[int] = []
	for i in range(0, len(follower_array)):
		if !is_instance_valid(follower_array[i]):
			temp_array.append(i)
	for i in temp_array:
		follower_array.remove_at(i)

func inc_PlayerSlow(times: int) -> void:
	if playerslow_mod == 1:
		playerslowlabelon = true
	playerslow_mod += times
	if playerslow_mod == 1:
			playerslowlabelon = true
	if playerslow_mod < playerslow_mod_limit:
		playerslow_mod_real = playerslow_mod
	else:
		playerslow_mod_real = playerslow_mod_limit
	updatelabels = true

func inc_Grow(times : int) -> void:
	if grow_mod == 0:
		growlabelon = true
	grow_mod += times
	if grow_mod == 0:
		growlabelon = true
	if grow_mod < grow_mod_limit:
		grow_mod_real = grow_mod
	else:
		grow_mod_real = grow_mod_limit
		
	if !follower_array.is_empty():
		change_player_follower_size()
		
	updatelabels = true

func inc_LongTele(times: int) -> void:
	if longtele_mod == 0:
		longtelelabelon = true
	longtele_mod += times
	if longtele_mod == 0:
		longtelelabelon = true
	updatelabels = true

func inc_ShortTele(times: int) -> void:
	if shorttele_mod == 0:
		shorttelelabelon = true
	shorttele_mod += times
	if shorttele_mod == 0:
		shorttelelabelon = true
	shortele_cool_down = shortele_cool_down_base * ((1/1.005) ** shorttele_mod)
	updatelabels = true

func cleanse_curse(times: int):
	var curse_dict : Dictionary = {}
	
	if playerslow_mod > playerslow_mod_base:
		curse_dict["playerslow"] = playerslow_mod
	if grow_mod > 0:
		curse_dict["grow"] = grow_mod
	if longtele_mod > 0:
		curse_dict["longtele"] = longtele_mod
	if shorttele_mod > 0:
		curse_dict["shorttele"] = shorttele_mod
	
	if curse_dict.is_empty():
		return
	
	for i in range(times):
		var chosen : String = curse_dict.keys().pick_random()
		
		if chosen == "playerslow":
			inc_PlayerSlow(-1)
			if playerslow_mod == playerslow_mod_base:
				curse_dict.erase(chosen)
		elif chosen == "grow":
			inc_Grow(-1)
			if grow_mod == 0:
				curse_dict.erase(chosen)
		elif chosen == "longtele":
			inc_LongTele(-1)
			if longtele_mod == 0:
				curse_dict.erase(chosen)
		elif chosen == "shorttele":
			inc_ShortTele(-1)
			if shorttele_mod == 0:
				curse_dict.erase(chosen)
		
		if curse_dict.is_empty():
			return

func change_player_follower_size() -> void:
		wipe_null_followers()
		var temp_shrink_per : float = 1 - (((shrink_mod_real*shrink_percent) 
		- (grow_mod_real*grow_percent))/100)
		var temp_shrinkxy : float = 1 * temp_shrink_per
		var temp_shrinkxy2 : float = 1.5 * temp_shrink_per
		var temp_shrink : Vector2 = Vector2(temp_shrinkxy, temp_shrinkxy)
		var temp_shrink2 : Vector2 = Vector2(temp_shrinkxy2, temp_shrinkxy2)
		for i in range(0, len(follower_array)):
			#print(follower_array[i].get_node("TopCollisionPolygon2D").scale)
			follower_array[i].get_node("TopCollisionPolygon2D").scale = temp_shrink
			follower_array[i].get_node("BotCollisionPolygon2D2").scale = temp_shrink
			follower_array[i].get_node("playermove").scale = temp_shrink2
			follower_array[i].get_node("shield").scale = temp_shrink
			follower_array[i].get_node("GlideBoots").scale = temp_shrink
			follower_array[i].get_node("FollowerCollision").scale = temp_shrink
