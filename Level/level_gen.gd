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
const SHIELD : Resource = preload("res://Items/Shield/shieldbattery.tscn")
const ITEMLABELS : Resource = preload("res://Items/itemlabels.tscn")
const DEFEAT : Resource = preload("res://menus/GameUI/game_over.tscn")
const PAUSE : Resource = preload("res://menus/GameUI/pause_panel.tscn")
const CHECKERDLINE : Resource  = preload("res://finishline/finish_line.tscn")
const GAMBAPICKER : Resource  = preload("res://Items/Gamba/Gamba.tscn")
@onready var DEFAULT_ITEM_LIST : Array[Array] = [["None"], ["Barrel"], ["Dumpster"],
 ["ExplBarrel"], ["Items"]]
# the DEFAULT_CHANCE_LIST does not have to add up to 100
@onready var DEFAULT_CHANCE_LIST : Array[float] = [800, 90, 50, 10, 45]
@onready var DEFAULT_ITEMS : Array[String] = ["PlayerSpeed", "GlideBoots", "Dash", "expl_B", "Grapplerope", "Shield", "Gamba"]
@onready var DEFAULT_ITEMs_CHANCE_LIST : Array[float] = [50, 50, 50, 50, 50, 1, 2]

@onready var BORDERS : Array = []
@onready var TERRAIN : Array = []

@onready var dashpopup : bool = true 
@onready var line : Area2D = null
@onready var hboxlabels : HBoxContainer = $CanvasLayer/HBoxContainer 

var sidewalk : bool = false

var iconlabels : Node = ITEMLABELS.instantiate()
var playerspeedicon : VBoxContainer = iconlabels.get_node("PlayerSpeedVbox").duplicate()
var glideicon : VBoxContainer = iconlabels.get_node("GlideVbox").duplicate()
var dashicon : VBoxContainer = iconlabels.get_node("DashVbox").duplicate()
var expl_B_icon : VBoxContainer = iconlabels.get_node("expl_B_Vbox").duplicate()
var grapple_icon : VBoxContainer = iconlabels.get_node("GrappleVbox").duplicate()

var gamba_picker : Node

func itemSpawn(items : Array[Array] = DEFAULT_ITEM_LIST, 
chances : Array[float] = DEFAULT_CHANCE_LIST, node_num: int = 15) -> void:
	var items_length : int = len(items)
	var chances_length : int = len(chances)
	# both arrays need to be same length
	if items_length != chances_length: return

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
			if items[a].has("ExplBarrel"):
				chance -= Global.expl_B_chance_mod
			
			if chance <= 0:
				selected_array = a
				break
		if selected_array == -1:
			print("Item Selection Failure. Leftover chance: ", chance)
			selected_array = chances_length - 1
			
		var lucky_array = items[selected_array] as Array[String]
		
		# randomly select from lucky array
		var lucky_item : String = lucky_array.pick_random()
		# spawn the lucky item
		match lucky_item:
			"None": pass
			"Barrel": i = spawnBarrel(dir, i)
			"Dumpster": i = spawnDumpster(dir, node_num, i)
			"ExplBarrel": i = spawnExplBarrel(dir, i)
			"PlayerSpeed": i = spawnItems(dir, 0, i)
			"GlideBoots": i = spawnItems(dir, 1, i)
			"Dash": i = spawnItems(dir, 2, i)
			"expl_B": i = spawnItems(dir, 3, i)
			"Grapplerope": i = spawnItems(dir, 4, i)
			"Shield": i = spawnItems(dir, 5, i)
			"Gamba": i = spawnItems(dir,6)
			_: print("This randomly selected item does not exist!:", lucky_item)
			
		i += 1

func spawnBarrel(dir : String, i : int) -> int:
	var barrel : StaticBody2D = BARREL.instantiate().duplicate()
	barrel.visible = true
	barrel.position = get_node(dir).global_position
	$Ysort.add_child(barrel)
	return i

func spawnDumpster(dir : String, node_num : int, i : int) -> int:
	# we have to check if this is the last node to prevent clipping out of bounds
	if i + 1 >= node_num: return i
	var dump : StaticBody2D = DUMP.instantiate().duplicate()
	dump.visible = true
	dump.position = get_node(dir).global_position
	$Ysort.add_child(dump)
	# dumpsters are two wide so we need to skip a spawn node
	return i + 1

func spawnExplBarrel(dir : String, i : int) -> int:
	var explbarrel : RigidBody2D = EXPLBARREL.instantiate().duplicate()
	explbarrel.visible = true
	explbarrel.position = get_node(dir).global_position
	$Ysort.add_child(explbarrel)
	return i

func spawnItems(dir : String, item_num: int, i : int) -> int:
	var item : Area2D
	if item_num == 5:
		item = SHIELD.instantiate().duplicate()
	else:
		item = ITEM.instantiate().get_node("Node" + str(item_num)).duplicate()
	item.visible = true
	item.position = get_node(dir).global_position
	$Ysort.add_child(item)
	return i

func carSpawn() -> void:
	var car : Node2D = CAR.instantiate().duplicate()
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
	var tile = TILES.instantiate().get_node("TileMap0").duplicate()
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
		
	#if event.is_action_pressed("rope"):
		#gamba_picker.begin_gamba()
		#print("test")
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
		
		playerspeedicon.get_node("PlayerSpeed").text = str(Global.player_speed_mod)
		glideicon.get_node("Glide").text = str(Global.glide_mod)
		dashicon.get_node("Dash").text = str(Global.dash_mod)
		expl_B_icon.get_node("expl_B").text = str(Global.expl_B_mod)
		grapple_icon.get_node("Grapple").text = str(Global.grapple_mod)

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
	var border : Node2D = BORDER.instantiate().duplicate()
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
	#gamba_picker.get_node("HBoxContainer").visible = false
	var input_array = []
	for i in [playerspeedicon, glideicon, dashicon, expl_B_icon, grapple_icon]:
		input_array.append(i.get_node("Sprite2D").texture)
	gamba_picker.item_pool = input_array
	gamba_picker.gamba_result_time_seconds = 2
	$CanvasLayer.add_child(gamba_picker)

func gamba_check() -> void:
	gamba_picker.begin_gamba()
