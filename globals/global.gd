extends Node

#verison
var version : String = "V 0.0.0.8"

#score
var score : int = 0

#gamestate
var defeat_var : bool = false
var sandbox : bool = false

#input
var input_active : bool = false
#var paused = false

var using_cont : bool = false

func _input(event: InputEvent) -> void:
	var prev_using_cont : bool = using_cont
	using_cont = event is InputEventJoypadMotion || event is InputEventJoypadButton
	if using_cont:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		if !prev_using_cont:
			get_tree().call_group("UI_FOCUS", "begin_focus")
	else: 
		if Input.get_mouse_mode() == Input.MOUSE_MODE_HIDDEN:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if prev_using_cont != using_cont:
		updatelabels = true

#region Base Values
#player
const player_base_speed : float = 750

#car
const car_base_speed : float = 125.0
#dash
const dash_base : float = 1.5
const dash_base_time : float = 0.3
const dash_cool_down_base : float = 5.0
#timer
const timer_base_l : float = 4.2
const timer_base_h : float = 5.4
#grapple
const grapple_cool_down_base : float = 2.0
const grapple_speed_base : float = 750
const grapple_strength_base : float = 725
const grapple_length_base : float = 250
const grapple_item_cool_down_base : float = 60
#glide
const glide_cool_down_base : float = 5.0
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
const tele_cool_down_base : float = 120
const itemtele_cool_down_base : float = 120
#dvdbounce
const dvd_vel_base : float = 250
#expl_b
const expl_B_impulse_mod_base : float = 2.0
const expl_B_size_mod_base : float = 1.0
const expl_B_chance_mod_base : int = 0
const expl_B_speed_penalty_base : float = 0.85
#hole
const hole_coyote_time_base : float = 0.1
const hole_cool_down_base : float = 60
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
var expl_B_impulse_mod : float = expl_B_impulse_mod_base
var expl_B_size_mod : float = expl_B_size_mod_base
var expl_B_chance_mod : int = expl_B_chance_mod_base
var expl_B_speed_penalty : float = expl_B_speed_penalty_base
var expl_B_speed_penalty_curr : float = 1

#Terrain
var spawnTerrain : bool = false

# player
var player_pos_x : float = 0.0
var player_pos_y : float = 0.0

# player attributes
const player_width_px : int = 48
const player_height_px : int = 74

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
var grapple_item_chosen : bool = false
var grapple_item_cool_down : float = grapple_item_cool_down_base


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
var tele_mod : int = 0
var itemtele_mod : int = 0
var tele_cool_down : float = tele_cool_down_base
var itemtele_cool_down : float = itemtele_cool_down_base
var telelabelon : bool = false
var itemtelelabelon : bool = false

# dvd_bounce
var dvd_spawn : bool = false
var dvd_mod : int = 0
var dvd_vel : float = 250
var dvd_array : Array[RigidBody2D] = []
var dvd_spawn_num : int = 0
var dvdbouncelabelon = false

#hole
var hole_coyote_time : float = hole_coyote_time_base
var hole_cool_down : float = hole_cool_down_base
var hole_mod : int = 0
var hole_cool_down_bool : bool = false
var holelabelon = false
var coyote_status_cool_down_bool : bool = false

#time
var stopwatch_time : float = 0
#endregion

func reset() -> void:
	# prevent memory leaks
	Globalpreload.delete_stray_nodes()
	#tiles
	tiles_spawned = 0
	race_condition_tiles.clear()
	if is_instance_valid(finish_line_tile):
		finish_line_tile.free()
	
	#input
	input_active = false
	#paused = false
	
	#score
	score = 0
	# gamestate
	defeat_var = false
	# playerspeed
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
	expl_B_impulse_mod = expl_B_impulse_mod_base
	expl_B_size_mod = expl_B_size_mod_base
	expl_B_chance_mod = expl_B_chance_mod_base
	expl_B_speed_penalty = expl_B_speed_penalty_base
	expl_B_speed_penalty_curr = 1

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
	telelabelon = false
	itemtelelabelon = false
	dvdbouncelabelon = false
	holelabelon = false
	updatelabels = false
	
	#grapplerope
	grapple = false
	grapple_cool_down = grapple_cool_down_base
	grapple_cool_down_bool = false
	grapple_mod = 0
	grapple_speed = grapple_speed_base
	grapple_strength = grapple_strength_base
	grapple_length = grapple_length_base
	grapple_item_chosen = false
	grapple_item_cool_down = grapple_item_cool_down_base
	
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
	playerslow_percent = playerslow_percent_base
	playerslow_mod = playerslow_mod_base
	playerslow_mod_real = playerslow_mod_base
	playerslow_mod_limit = playerslow_mod_limit_base
	
	#grow
	grow_mod = 0
	grow_mod_real = grow_mod
	grow_percent = grow_percent_base
	grow_mod_limit = grow_mod_limit_base
	
	#line
	if is_instance_valid(game_line):
		game_line.free()
	
	# tele
	tele_mod = 0
	itemtele_mod = 0
	tele_cool_down = tele_cool_down_base
	itemtele_cool_down = itemtele_cool_down_base
	
	# dvd_bounce
	dvd_spawn = false
	dvd_mod = 0
	dvd_vel = dvd_vel_base
	dvd_spawn_num = 0
	for i in range(dvd_array.size()):
		if is_instance_valid(dvd_array[i]): dvd_array[i].queue_free()
	dvd_array.clear()
	
	#hole
	hole_coyote_time = hole_coyote_time_base
	hole_cool_down = hole_cool_down_base
	hole_mod = 0
	hole_cool_down_bool = false
	coyote_status_cool_down_bool = false
	
	#time
	stopwatch_time  = 0

func incrementDifficulty(x : int = 2, int_multiple : float = 1) -> void:
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
	get_tree().call_group("UI_FOCUS_STARTSCREEN", "become_background")
	
func options_down() -> void:
	if pause_popup != null && pause_popup.visible == true:
		pause_popup.set_process(true)
	elif score == -1:
		get_tree().paused = false
	options_pop_up.set_visible(false)
	get_tree().call_group("UI_FOCUS_STARTSCREEN", "become_foreground")
	get_tree().call_group("UI_FOCUS", "begin_focus_options")

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
	if player_speed_mod + times < 0:
		player_speed_mod = 0
		times = 0
	player_speed_mod += times
	player_speed_scaling = player_base_speed + 20 * player_speed_mod
	playerspeedlabelon = true
	updatelabels = true
	logbook_tracking("Items", "PlayerSpeed")

func inc_GlideBoots(times : int) -> void:
	if glide_mod + times < 0:
		glide_mod = 0
		times = 0
		glide = false
	elif glide_mod == 0:
		glide = true
	elif glide_mod + times == 0:
		glide = false
	glide_mod += times
	glide_cool_down = glide_cool_down_base * ((1/1.05) ** glide_mod)
	glide_time = glide_base_time + 0.025 * glide_mod
	glidelabelon = true
	updatelabels = true
	logbook_tracking("Items", "GlideBoots")
	
func inc_Dash(times : int) -> void:
	if dash_mod + times < 0:
		dash_mod = 0
		times = 0
		dash = false
	elif dash_mod == 0:
		dash = true
	elif dash_mod + times == 0:
		dash = false

	dash_mod += times
	dash_scaling = dash_base + 0.02 * dash_mod
	dash_time = dash_base_time/(dash_scaling/dash_base)
	dash_cool_down = dash_cool_down_base * ((1/1.05) ** dash_mod)
	dashlabelon = true
	updatelabels = true
	logbook_tracking("Items", "Dash")
	
func inc_expl_B(times : int) -> void:
	if expl_B_mod + times < 0:
		expl_B_mod = 0
		times = 0

	expl_B_mod += times
	expl_B_impulse_mod = expl_B_impulse_mod_base + 0.1 * expl_B_mod
	expl_B_size_mod = expl_B_size_mod_base + 0.02 * expl_B_mod
	expl_B_chance_mod = expl_B_mod * 3
	expl_B_labelon = true
	updatelabels = true
	logbook_tracking("Items", "expl_B")

func inc_GrappleRope(times : int) -> void:
	if grapple_mod + times < 0:
		grapple_mod = 0
		times = 0

	elif grapple_mod == 0:
		grapple = true

	elif grapple_mod + times == 0:
		grapple = false

	grapple_mod += times
	grapple_speed = grapple_speed_base + 10 * grapple_mod
	grapple_strength = grapple_strength_base + 25 * grapple_mod
	grapple_length = grapple_length_base + 5 * grapple_mod
	grapple_cool_down = grapple_cool_down_base * ((1/1.1) ** grapple_mod)
	grapple_item_cool_down = grapple_item_cool_down_base * ((1/1.1) ** grapple_mod)
	grapplelabelon = true
	updatelabels = true
	logbook_tracking("Items", "Grapple")

func inc_Follower(times : int) -> void:
	if follower_mod + times < follower_mod_base:
		times = 0
		follower_mod = follower_mod_base
		for i in range(follower_array.size() - 1, 0, -1):
			follower_array[i].remove_follower()
	follower_mod += times
	if times > 0:
		spawn_follower_bool = true
		follower_spawn_multi = times
		Follower = true
	else:
		var f_count_idx : int = follower_array.size() - 1
		var f_count : int = 0
		while f_count < -1*times and f_count_idx > 0:
			follower_array[f_count_idx].remove_follower()
			f_count_idx -= 1
			f_count += 1
	
	followerlabelon = true
	updatelabels = true
	logbook_tracking("Items", "Follower")

func inc_Shrink(times : int) -> void:
	if shrink_mod + times < 0:
		shrink_mod = 0
		times = 0
	shrink_mod += times
	if shrink_mod < shrink_mod_limit:
		shrink_mod_real = shrink_mod
	else:
		shrink_mod_real = shrink_mod_limit
		
	if !follower_array.is_empty():
		change_player_follower_size()
	
	shrinklabelon = true
	updatelabels = true
	logbook_tracking("Items", "Shrink")

func inc_Gamba(times : int) -> void:
	if gamba_running:
		gamba_mod += times
	elif !(gamba_update || gamba_done):
		gamba_mod += times - 1
		gamba_update = true
	logbook_tracking("Items", "Gamba")

func wipe_null_followers() -> void:
	var temp_array : Array[int] = []
	for i in range(0, len(follower_array)):
		if !is_instance_valid(follower_array[i]):
			temp_array.append(i)
	for i in temp_array:
		follower_array.remove_at(i)

func inc_PlayerSlow(times: int) -> void:
	if playerslow_mod + times < playerslow_mod_base:
		playerslow_mod = playerslow_mod_base
		times = 0
	
	playerslow_mod += times

	if playerslow_mod < playerslow_mod_limit:
		playerslow_mod_real = playerslow_mod
	else:
		playerslow_mod_real = playerslow_mod_limit
	
	playerslowlabelon = true
	updatelabels = true
	logbook_tracking("Curses", "Slow")

func inc_Grow(times : int) -> void:
	if grow_mod + times < 0:
		grow_mod = 0
		times = 0
	grow_mod += times
	if grow_mod < grow_mod_limit:
		grow_mod_real = grow_mod
	else:
		grow_mod_real = grow_mod_limit
		
	if !follower_array.is_empty():
		change_player_follower_size()
	
	growlabelon = true
	updatelabels = true
	logbook_tracking("Curses", "Grow")

func inc_Tele(times: int) -> void:
	if tele_mod + times < 0:
		tele_mod = 0
		times = 0
	tele_mod += times
	tele_cool_down = tele_cool_down_base * ((1/1.01) ** tele_mod)
	telelabelon = true
	updatelabels = true
	logbook_tracking("Curses", "Teleport")

func inc_ItemTele(times: int) -> void:
	if itemtele_mod + times < 0:
		itemtele_mod = 0
		times = 0
	itemtele_mod += times
	itemtele_cool_down = itemtele_cool_down_base * ((1/1.01) ** itemtele_mod)
	itemtelelabelon = true
	updatelabels = true
	logbook_tracking("Curses", "ItemTeleport")

func inc_DVD(times : int) -> void:
	if dvd_mod + times < 0:
		dvd_mod = 0
		times = 0
		for i in range(0, dvd_array.size()):
			if is_instance_valid(dvd_array[i]): dvd_array[i].queue_free()
		dvd_array.clear()
	dvd_mod += times
	dvd_spawn_num = times
	if times > 0:
		dvd_spawn = true
	elif times < 0:
		for i in range(-1*dvd_spawn_num):
			if dvd_array.is_empty():
				break
			else:
				if is_instance_valid(dvd_array[0]): dvd_array[0].queue_free()
				dvd_array.remove_at(0)
	dvdbouncelabelon = true
	updatelabels = true
	logbook_tracking("Curses", "DVDBounce")

func cleanse_curse(times: int):
	logbook_tracking("Items", "Cleanse")
	var curse_dict : Dictionary = {}

	if playerslow_mod > playerslow_mod_base:
		curse_dict["playerslow"] = playerslow_mod
	if grow_mod > 0:
		curse_dict["grow"] = grow_mod
	if tele_mod > 0:
		curse_dict["tele"] = tele_mod
	if itemtele_mod > 0:
		curse_dict["itemtele"] = itemtele_mod
	if dvd_mod > 0:
		curse_dict["DVDBounce"] = dvd_mod
	
	if curse_dict.is_empty(): return
	
	for i in range(times):
		var curse_size : int = curse_dict.keys().size()
		if curse_dict.is_empty() || curse_size == 0: return
		var chosen : String = curse_dict.keys()[
			GRand.itemrand.randi() % curse_size]
		
		if chosen == "playerslow":
			inc_PlayerSlow(-1)
			curse_dict[chosen] = curse_dict[chosen] - 1
			if curse_dict[chosen] == playerslow_mod_base:
				curse_dict.erase(chosen)
		elif chosen == "grow":
			inc_Grow(-1)
			curse_dict[chosen] = curse_dict[chosen] - 1
			if curse_dict[chosen] == 0:
				curse_dict.erase(chosen)
		elif chosen == "tele":
			inc_Tele(-1)
			curse_dict[chosen] = curse_dict[chosen] - 1
			if curse_dict[chosen] == 0:
				curse_dict.erase(chosen)
		elif chosen == "itemtele":
			inc_ItemTele(-1)
			curse_dict[chosen] = curse_dict[chosen] - 1
			if curse_dict[chosen] == 0:
				curse_dict.erase(chosen)
		elif chosen == "DVDBounce":
			inc_DVD(-1)
			curse_dict[chosen] = curse_dict[chosen] - 1
			if curse_dict[chosen] == 0:
				curse_dict.erase(chosen)

func inc_Hole(times : int) -> void:
	if hole_mod + times < 0:
		hole_mod = 0
		times = 0
	hole_mod += times
	hole_coyote_time = hole_coyote_time_base * hole_mod
	hole_cool_down = hole_cool_down_base * ((1/1.05) ** hole_mod)
	holelabelon = true
	updatelabels = true
	logbook_tracking("Items", "Hole")

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
			follower_array[i].get_node("feet").scale = temp_shrink
			follower_array[i].get_node("CollisionReveal").scale = temp_shrink
			follower_array[i].get_node("FeetCollisionRevealMarker2D").scale = temp_shrink

func logbook_tracking(type : String, object : String) -> void:
	var firsttime : bool = SettingsDataContainer.get_logbook_dict(
		type, object)[0]
	SettingsSignalBus.emit_on_logbook_dict_set(type, object, true, 0)
	if !firsttime || SettingsDataContainer.get_tutorials_always_on():
		get_tree().root.get_node("Level/CanvasLayer/TipPopup").call_deferred(
			"loadTip", object, type)

func teleportation_activated() -> void:
	var playermove: AnimatedSprite2D = follower_array[0].get_node("playermove")
	var self_mod_red : Color = Color(1.0, 0.0 ,0.0)
	var self_mod_none : Color = Color(1.0, 1.0 ,1.0)
	playermove.self_modulate = self_mod_red
	await get_tree().create_timer(1).timeout
	if is_instance_valid(playermove):
		playermove.self_modulate = self_mod_none
	else: return
	await get_tree().create_timer(0.5).timeout
	if is_instance_valid(playermove):
		playermove.self_modulate = self_mod_red
	else: return
	await get_tree().create_timer(0.25).timeout
	if is_instance_valid(playermove):
		playermove.self_modulate = self_mod_none
	else: return
	await get_tree().create_timer(0.125).timeout
	if is_instance_valid(playermove):
		playermove.self_modulate = self_mod_red
	else: return
	await get_tree().create_timer(0.0625).timeout
	if is_instance_valid(playermove):
		playermove.self_modulate = self_mod_none
	else: return
	await get_tree().create_timer(0.05).timeout
	if is_instance_valid(playermove):
		playermove.self_modulate = self_mod_red
	else: return
	await get_tree().create_timer(0.05).timeout
	if is_instance_valid(playermove):
		playermove.self_modulate = self_mod_none
	else: return
	await get_tree().create_timer(0.05).timeout
	if is_instance_valid(playermove):
		playermove.self_modulate = self_mod_red
	else: return
	await get_tree().create_timer(0.05).timeout
	if is_instance_valid(playermove):
		playermove.self_modulate = self_mod_none
	else: return
	await get_tree().create_timer(0.05).timeout
	Global.follower_array[0].rand_teleport(Vector2.ZERO)

func get_texture_icons(object : String, topic : String) -> Texture2D:
	match object:
		"PlayerSpeed" : return Globalpreload.PlayerSpeed_t
		"GlideBoots" : return Globalpreload.GlideBoots_t
		"Dash" :  return Globalpreload.Dash_t
		"expl_B" : return Globalpreload.expl_B_t
		"Grapple" : return Globalpreload.Grapple_t
		"Follower" : return Globalpreload.Follower_t
		"Gamba" : return Globalpreload.Gamba_t
		"Shield" :  return Globalpreload.Shield_t
		"Shrink" :  return Globalpreload.Shrink_t
		"Cleanse" : return Globalpreload.Cleanse_t
		"Hole" : return Globalpreload.Hole_t
		"ExplBarrel" : return Globalpreload.ExplBarrel_t
		"ExplBarrelPickUpEvent" : return Globalpreload.ExplBarrel_t
		"Dumpster" : return Globalpreload.Dumpster_t
		"Barrel" : return Globalpreload.Barrel_t
		"Hole_Sidewalk_Street" : return Globalpreload.HolePrev_t
		"Hole_Sidewalk" : return Globalpreload.HolePrev_t
		"Hole_Street" : return Globalpreload.HolePrev_t
		"Slow" : return Globalpreload.Slow_t
		"Grow" : return Globalpreload.Grow_t
		"Teleport" : return Globalpreload.Teleport_t
		"ItemTeleport" :  return Globalpreload.ItemTeleport_t
		"DVDBounce" :  return Globalpreload.DVDBounce_t
		_: print("set texture string was not there for {topic}: {object}".format({"topic": topic, "object": object}))
	return null

func convert_keyword_to_title(keyword : String) -> String:
	match keyword:
		"ExplBarrel" : return "Exploding Barrel"
		"expl_B" : return "Exploding Barrel (Item)"
		"ExplBarrelPickUpEvent" : return "Exploding Barrel"
	return keyword
