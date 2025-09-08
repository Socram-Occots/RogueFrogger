# level_gen.gd
extends Node

# importing
const CAR : Resource = preload("res://Car/car.tscn")
const ITEM : Resource = preload("res://Items/items.tscn")
const BARREL : Resource = preload("res://Barrel/barrel.tscn")
const TILES : Resource = preload("res://tilemaps/tilemaps.tscn")
const CROSSER : Resource = preload("res://Crosser/crosser.tscn")
const DUMP : Resource = preload("res://Dumpster/dumpster.tscn")
const BORDER : Resource = preload("res://Level/border.tscn")
const LINE : Resource = preload("res://lineofdeath/lineofdeath.tscn")
const POP : Resource = preload("res://menus/GameUI/popups.tscn")
const EXPLBARREL : Resource = preload("res://Barrel/exploding_barrel.tscn")
const ITEMLABELS : Resource = preload("res://Items/itemlabels.tscn")
const DEFEAT : Resource = preload("res://menus/GameUI/game_over.tscn")
const PAUSE : Resource = preload("res://menus/GameUI/pause_panel.tscn")
const CHECKERDLINE : Resource  = preload("res://finishline/finish_line.tscn")
const GAMBAPICKER : Resource  = preload("res://Items/Gamba/Gamba.tscn")
const FOLLOWERSCRIPT : Script = preload("res://Follower/followerLogic.gd")

@onready var DEFAULT_SPAWN_LIST : Array[Array] = [["None"], ["Barrel"], 
["Dumpster"], ["ExplBarrel"], ["Items"]]
# the DEFAULT_CHANCE_LIST does not have to add up to 100
@onready var DEFAULT_CHANCE_LIST : Array[float] = [800, 90, 50, 
10, 50]
@onready var DEFAULT_ITEMS : Array[String] = ["PlayerSpeed", 
"GlideBoots", "Dash", "expl_B", "GrappleRope", "Shield", 
"Gamba", "Follower", "Shrink", "Multi"]
@onready var DEFAULT_ITEMS_CHANCE_LIST : Array[float] = [50, 50, 
50, 50, 50, 1, 50, 5, 50, 100]

@onready var BORDERS : Array = []
@onready var TERRAIN : Array = []

@onready var dashpopup : bool = true 
@onready var line : Area2D = null
@onready var hboxlabels : HBoxContainer = $CanvasLayer/HBoxContainer 

@onready var curr_follower_id : int = 1

var CAR_INST : Node2D = CAR.instantiate()
var BARREL_INST : StaticBody2D = BARREL.instantiate()
var TILES_INST : Node2D = TILES.instantiate()
var DUMP_INST : StaticBody2D = DUMP.instantiate()
var BORDER_INST : Node2D = BORDER.instantiate()
var EXPLBARREL_INST : RigidBody2D = EXPLBARREL.instantiate()

var sidewalk : bool = false

# icons
var iconlabels : Node = ITEMLABELS.instantiate()
var playerspeedicon : VBoxContainer = iconlabels.get_node("PlayerSpeedVbox").duplicate()
var glideicon : VBoxContainer = iconlabels.get_node("GlideVbox").duplicate()
var dashicon : VBoxContainer = iconlabels.get_node("DashVbox").duplicate()
var expl_B_icon : VBoxContainer = iconlabels.get_node("expl_B_Vbox").duplicate()
var grapple_icon : VBoxContainer = iconlabels.get_node("GrappleVbox").duplicate()
var follower_icon : VBoxContainer = iconlabels.get_node("FollowerVbox").duplicate()
var shrink_icon : VBoxContainer = iconlabels.get_node("ShrinkVbox").duplicate()

# glowicons
var items_instantiate : Node = ITEM.instantiate()
var playerspeedglowicon : Texture2D = items_instantiate.get_node("PlayerSpeed/Sprite2D").texture
var glideglowicon : Texture2D = items_instantiate.get_node("GlideBoots/Sprite2D").texture
var dashglowicon : Texture2D = items_instantiate.get_node("Dash/Sprite2D").texture
var expl_B_glowicon : Texture2D = items_instantiate.get_node("expl_B/Sprite2D").texture
var grapple_glowicon : Texture2D = items_instantiate.get_node("GrappleRope/Sprite2D").texture
var follower_glowicon : Texture2D = items_instantiate.get_node("Follower/Sprite2D").texture
var shrink_glowicon : Texture2D = items_instantiate.get_node("Shrink/Sprite2D").texture
var gamba_glowicon : Texture2D = items_instantiate.get_node("Gamba/Sprite2D").texture
var shield_glowicon : Texture2D = items_instantiate.get_node("Shield/Sprite2D").texture

var item_glowlist : Array[Array] = [["Gamba", gamba_glowicon],
 ["Shrink", shrink_glowicon], ["Follower", follower_glowicon],
 ["PlayerSpeed", playerspeedglowicon], ["GlideBoots", glideglowicon],
 ["Dash", dashglowicon], ["expl_B", expl_B_glowicon],
 ["GrappleRope", grapple_glowicon], ["Shield", shield_glowicon]]

@onready var DEFAULT_MULTI_LIST : Array[String] = ["Gamba", "Shrink",
"Follower", "PlayerSpeed", "GlideBoots", "Dash", "expl_B", "GrappleRope",
"Shield"]
@onready var DEFAULT_MULTI_CHANCE_LIST : Array[int] = [50, 50, 5, 50, 50, 50, 
50, 50, 1]

var gamba_picker : Node

@onready var multi_quantity_sum_divide_const : float = 2
@onready var multi_quantity_sum : float = sum_multi_chances(9)

func sum_multi_chances(max_items : int = 9) -> float:
	var initial : float = 150
	var total : float = 150
	for i in range(1, max_items - 1):
		total += initial / (multi_quantity_sum_divide_const*i)
	return total

func itemSpawn(spawns : Array[Array] = DEFAULT_SPAWN_LIST, 
chances : Array[float] = DEFAULT_CHANCE_LIST, 
items : Array[String] = DEFAULT_ITEMS, 
items_chances : Array[float] = DEFAULT_ITEMS_CHANCE_LIST, 
node_num: int = 15) -> void:
	var spawn_length : int = len(spawns)
	var chances_length : int = len(chances)
	var item_length : int = len(items)
	var item_chances_length : int = len(items_chances)
	
	# both arrays need to be same length
	if spawn_length != chances_length || item_length != item_chances_length: return

	# at least one space must be open
	var open : int  = randi_range(0, node_num - 1)
	
	var i : int = 0
	var chance_pool : float = Global.float_sum_array(chances)
	# adding ingame modified item chances
	chance_pool += Global.expl_B_chance_mod
	
	var selected_array : int = -1
	while i < node_num:
		if i == open: i += 1
		if i == node_num: break
		var chance : float = randf_range(0, chance_pool)
		var dir : String = "spawnterrain/Node" + str(i)
		for a in range(0, chances_length):
			chance -= chances[a]
			
			# subtracting ingame modified item chances
			if spawns[a].has("ExplBarrel"):
				chance -= Global.expl_B_chance_mod
			
			if chance <= 0:
				selected_array = a
				break
		if selected_array == -1:
			print("Spawn Selection Failure. Leftover chance: ", chance)
			selected_array = chances_length - 1
			
		var lucky_array = spawns[selected_array] as Array[String]
		
		# randomly select from lucky array
		var lucky_spawn : String = lucky_array.pick_random()
		
		if lucky_spawn == "Items":
			var selected_item : int = -1
			var item_chance_pool : float = Global.float_sum_array(items_chances)
			chance = randf_range(0, item_chance_pool)
			for a in range(0, item_chances_length):
				chance -= items_chances[a]
				
				if chance <= 0:
					selected_item = a
					break
					
			if selected_item == -1:
				print("Item Selection Failure. Leftover chance: ", chance)
				selected_item = chances_length - 1
				
			lucky_spawn = items[selected_item]
		
		# spawn the lucky item
		match lucky_spawn:
			"None": pass
			"Barrel": i = spawnBarrel(dir, i)
			"Dumpster": i = spawnDumpster(dir, node_num, i)
			"ExplBarrel": i = spawnExplBarrel(dir, i)
			"PlayerSpeed": i = spawnItems(dir, lucky_spawn, i)
			"GlideBoots": i = spawnItems(dir, lucky_spawn, i)
			"Dash": i = spawnItems(dir, lucky_spawn, i)
			"expl_B": i = spawnItems(dir, lucky_spawn, i)
			"GrappleRope": i = spawnItems(dir, lucky_spawn, i)
			"Shield": i = spawnItems(dir, lucky_spawn, i)
			"Gamba": i = spawnItems(dir, lucky_spawn,i)
			"Follower": i = spawnItems(dir, lucky_spawn,i)
			"Shrink": i = spawnItems(dir,lucky_spawn, i)
			"Multi": i = spawnItems(dir,lucky_spawn, i)
			_: print("This randomly selected item does not exist!:", lucky_spawn)
			
		i += 1

func multiItemPicker(mulit_list : Array[String] = DEFAULT_MULTI_LIST,
multi_chance_list : Array[int] = DEFAULT_MULTI_CHANCE_LIST, num_of_multi : int = 9) -> Array[Array]:
	var result_multi_list : Array[Array] = []
	var mulit_list_copy = mulit_list.duplicate(true)
	var multi_chance_list_copy = multi_chance_list.duplicate(true)
	var multi_chance_pool : float = Global.float_sum_array(multi_chance_list_copy)
	var multi_chances_length : int = multi_chance_list_copy.size()
	var initial : float = 150
	var multi_quantity : int = 2
	var lucky_multi : String
	
	var multi_quantity_sum_chance = randf_range(0, multi_quantity_sum) - initial
	for i in range(1, num_of_multi):
		if multi_quantity_sum_chance <= 0:
			multi_quantity = i + 1
			break
		multi_quantity_sum_chance -= initial / (multi_quantity_sum_divide_const*i)
	
	result_multi_list.resize(multi_quantity)

	for i in range(0, multi_quantity):

		var selected_multi : int = -1
		var chance : float = randf_range(0, multi_chance_pool)
		
		for a in range(0, multi_chances_length):
			chance -= multi_chance_list_copy[a]
			
			if chance <= 0:
				selected_multi = a
				break
				
		if selected_multi == -1:
			print("Multi Selection Failure. Leftover chance: ", chance)
			selected_multi = multi_chances_length - 1
		
		lucky_multi = mulit_list_copy[selected_multi]

		# spawn the lucky item
		match lucky_multi:
			"None": pass
			"PlayerSpeed": result_multi_list[i] = [lucky_multi, playerspeedglowicon]
			"GlideBoots": result_multi_list[i] = [lucky_multi, glideglowicon]
			"Dash": result_multi_list[i] = [lucky_multi, dashglowicon]
			"expl_B": result_multi_list[i] = [lucky_multi, expl_B_glowicon]
			"GrappleRope": result_multi_list[i] = [lucky_multi, grapple_glowicon]
			"Shield": result_multi_list[i] = [lucky_multi, shield_glowicon]
			"Gamba": result_multi_list[i] = [lucky_multi, gamba_glowicon]
			"Follower": result_multi_list[i] = [lucky_multi, follower_glowicon]
			"Shrink": result_multi_list[i] = [lucky_multi, shrink_glowicon]
			_: print("This randomly selected multi does not exist!:", lucky_multi)
		
		multi_chance_pool -= multi_chance_list_copy[selected_multi]
		multi_chance_list_copy.remove_at(selected_multi)
		mulit_list_copy.remove_at(selected_multi)
		multi_chances_length -= 1

	return result_multi_list

func spawnBarrel(dir : String, i : int) -> int:
	var barrel : StaticBody2D = BARREL_INST.duplicate()
	barrel.visible = true
	barrel.position = get_node(dir).global_position
	$Ysort.add_child(barrel)
	return i

func spawnDumpster(dir : String, node_num : int, i : int) -> int:
	# we have to check if this is the last node to prevent clipping out of bounds
	if i + 1 >= node_num: return i
	var dump : StaticBody2D = DUMP_INST.duplicate()
	dump.visible = true
	dump.position = get_node(dir).global_position
	$Ysort.add_child(dump)
	# dumpsters are two wide so we need to skip a spawn node
	return i + 1

func spawnExplBarrel(dir : String, i : int) -> int:
	var explbarrel : RigidBody2D = EXPLBARREL_INST.duplicate()
	explbarrel.visible = true
	explbarrel.position = get_node(dir).global_position
	$Ysort.add_child(explbarrel)
	return i

func spawnItems(dir : String, item_str: String, i : int) -> int:
	var item : Area2D = items_instantiate.get_node(item_str).duplicate()
	if item_str == "Multi":
		item.item_pool = multiItemPicker()
	item.visible = true
	item.position = get_node(dir).global_position
	$Ysort.add_child(item)
	return i

func carSpawn() -> void:
	var car : Node2D = CAR_INST.duplicate()
	car.position.y = $spawnterrain/Node0.global_position.y - 5
	car.visible = true
	
	var side : int = randi_range(0,1)
	if side == 0:
		car.position.x = Global.despawn_left
	else:
		car.position.x = Global.despawn_right
		
	$Ysort.add_child(car)

func firstTerrainSpawn(xpos : float, ypos : float) -> void:
#	var tile_num = randi_range(0,1)
	sidewalk = true
	var tile = TILES_INST.get_node("TileMap0").duplicate()
	tile.position.x = xpos
	tile.position.y = ypos
	tile.visible = true
	TERRAIN.append(tile) 
	$spawnterrain.global_position.y -= 144
	
	$Tiles.add_child(tile)

func terrainSpawn(type : int, xpos : float, ypos : float) -> void:
#	var tile_num = randi_range(0,1)
	if type == 0:
		sidewalk = true
	else:
		sidewalk = false
		
	var tile = TILES.instantiate().get_node("TileMap" + str(type)).duplicate()
	tile.position.x = xpos
	tile.position.y = ypos
	tile.visible = true
	
	TERRAIN.append(tile)
	
	$Tiles.add_child(tile)
	# item or car spawn
	if type == 0:
		itemSpawn()
	elif type == 1:
		carSpawn()
	
	$spawnterrain.global_position.y -= 144

@warning_ignore("unused_parameter")
func _input(event):
	#if event.is_action_pressed("down_s")\
	#|| event.is_action_pressed("up_w")\
	#|| event.is_action_pressed("left_a")\
	#|| event.is_action_pressed("right_d"):
		#Global.input_active = true
	#elif event.is_action_released("down_s")\
	#|| event.is_action_released("up_w")\
	#|| event.is_action_released("left_a")\
	#|| event.is_action_released("right_d"):
		#Global.input_active = false
		
	#if event.is_action_pressed("dash"):
		#Global.inc_Shrink(1)
	#if event.is_action_pressed("rope"):
		##gamba_picker.begin_gamba()
		##print("test")
		##create_follower()
		#Global.inc_PlayerSlow(1)
	pass

func terrainSpawnLogic() -> void:
	if sidewalk:
		terrainSpawn(1, 0, $spawnterrain.global_position.y)
	else:
		var tile_num = randi_range(0,1)
		terrainSpawn(tile_num, 0, $spawnterrain.global_position.y)
		
#	print(TERRAIN[0].global_position.y)
#	print(Global.player_pos_y)
	if !TERRAIN.is_empty() && TERRAIN[0].global_position.y - Global.player_pos_y > Global.despawn_lower:
		TERRAIN[0].queue_free()
		TERRAIN.remove_at(0)

func update_labels() -> void:
	if Global.updatelabels:
		Global.updatelabels = false
		if Global.playerspeedlabelon:
			hboxlabels.add_child(playerspeedicon)
			Global.playerspeedlabelon = false
		elif  Global.glidelabelon:
			hboxlabels.add_child(glideicon)
			Global.glidelabelon = false
		elif Global.dashlabelon:
			hboxlabels.add_child(dashicon)
			Global.dashlabelon = false
		elif Global.expl_B_labelon:
			hboxlabels.add_child(expl_B_icon)
			Global.expl_B_labelon = false
		elif Global.grapplelabelon:
			hboxlabels.add_child(grapple_icon)
			Global.grapplelabelon = false
		elif Global.followerlabelon:
			if Global.follower_mod == 1:
				hboxlabels.remove_child(follower_icon)
			else:
				hboxlabels.add_child(follower_icon)
			Global.followerlabelon = false
		elif Global.shrinklabelon:
			hboxlabels.add_child(shrink_icon)
			Global.shrinklabelon = false
		
		playerspeedicon.get_node("PlayerSpeed").text = str(Global.player_speed_mod)
		glideicon.get_node("Glide").text = str(Global.glide_mod)
		dashicon.get_node("Dash").text = str(Global.dash_mod)
		expl_B_icon.get_node("expl_B").text = str(Global.expl_B_mod)
		grapple_icon.get_node("Grapple").text = str(Global.grapple_mod)
		follower_icon.get_node("Follower").text = str(Global.follower_mod - 1)
		shrink_icon.get_node("Shrink").text = str(Global.shrink_mod)

func dash_check() -> void:
	if Global.dash && dashpopup: 
		dashpopup = false
		var dash_pop_up : Control = POP.instantiate()
		$CanvasLayer.add_child(dash_pop_up)

func terrain_check() -> void:
	if Global.spawnTerrain:
		$CanvasLayer/Score.text = "Score " + str(Global.score)
		Global.spawnTerrain = false
		terrainSpawnLogic()
		Global.incrementDifficulty(2)
		if Global.score % 100 == 0:
			spawnBorder(960, Global.player_pos_y)

func spawnBorder(x : float, y : float) -> void:
	var border : Node2D = BORDER_INST.duplicate()
	border.position.x = x
	border.position.y = y
#	print(border.global_position)
	BORDERS.append(border)
	$border.add_child(border)
	if BORDERS.size() > 1:
		BORDERS[0].queue_free()
		BORDERS.remove_at(0)

func spawnLineOfDeath() -> void:
	line = LINE.instantiate()
	line.position.x = 0
	line.position.y = 1500
	$lineofdeath.add_child(line)

func loadDefeat() -> void:
	var losepopup : Control = DEFEAT.instantiate().duplicate()
	losepopup.visible = false
	$CanvasLayer.add_child(losepopup)
	Global.game_over_pop_up = losepopup

func loadPause() -> void:
	var pausepopup : Control = PAUSE.instantiate().duplicate()
	pausepopup.visible = false
	$CanvasLayer.add_child(pausepopup)
	Global.pause_popup = pausepopup

func spawn_high_score_line() -> void:
	var high_score : int = SettingsDataContainer.get_high_score()
	# don't spawn line at score 0
	if high_score < 1: return
	
	var high_score_dist : int = (high_score + 1) * -144 + 936
	var high_score_line : Node2D = CHECKERDLINE.instantiate()
	high_score_line.position.x = 0
	high_score_line.position.y = high_score_dist
	$lineofdeath.add_child(high_score_line)

func load_gamba_picker() -> void:
	gamba_picker = GAMBAPICKER.instantiate()
	var temp_array : Array[Array] = [["Shrink", shrink_icon], 
	["Follower", follower_icon], ["PlayerSpeed", playerspeedicon], 
	["GlideBoots", glideicon], ["Dash", dashicon], 
	["expl_B", expl_B_icon], ["GrappleRope", grapple_icon]]
	var input_array : Array[Array] = []
	for i in temp_array:
		input_array.append([i[0], i[1].get_node("Sprite2D").texture])
	gamba_picker.item_pool = input_array
	gamba_picker.gamba_result_time_seconds = 2
	$CanvasLayer.add_child(gamba_picker)

func gamba_check() -> void:
	if Global.gamba_update:
		Global.gamba_update = false
		Global.gamba_running = true
		gamba_picker.begin_gamba()
		
func create_follower() -> void:
	var follower_basic = CROSSER.instantiate()
	for i in range(Global.follower_spawn_multi):
		var follower : RigidBody2D = follower_basic.duplicate()
		var follower_in_front : RigidBody2D = Global.follower_array[-1]
		
		follower.set_script(FOLLOWERSCRIPT)
		follower.get_node("Camera2D").queue_free()
		#follower.get_node("shield").queue_free()
		follower.remove_meta("Player")
		follower.set_meta("Follower", curr_follower_id)
		
		curr_follower_id += 1
		#follower.set_collision_layer_value(1, false)
		
		var timer = Timer.new()
		timer.autostart = true
		timer.wait_time = 0.05
		timer.timeout.connect(follower._on_timer_timeout)
		follower.add_child(timer)
		
		var follower_in_front_pos : Vector2 = follower_in_front.get_node("BotCollisionPolygon2D2/followerspawn").global_position
		follower.position = follower_in_front_pos
		
		follower.get_node("TopCollisionPolygon2D").scale = follower_in_front.get_node("TopCollisionPolygon2D").scale
		follower.get_node("BotCollisionPolygon2D2").scale = follower_in_front.get_node("BotCollisionPolygon2D2").scale
		follower.get_node("playermove").scale = follower_in_front.get_node("playermove").scale
		follower.get_node("shield").scale = follower_in_front.get_node("shield").scale
		follower.get_node("GlideBoots").scale = follower_in_front.get_node("GlideBoots").scale
		follower.get_node("FollowerCollision").scale = follower_in_front.get_node("FollowerCollision").scale
		
		Global.follower_array.append(follower)
		$Ysort.add_child(follower)
	
	Global.follower_spawn_multi = Global.follower_spawn_multi_base

func follower_check() ->void:
	if Global.Follower:
		Global.Follower = false
		create_follower()
