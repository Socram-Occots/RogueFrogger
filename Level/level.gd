extends Node

# importing
const CAR = preload("res://Car/car.tscn")
const ITEM = preload("res://Items/items.tscn")
const BARREL = preload("res://Barrel/barrel.tscn")
const TILES = preload("res://tilemaps/tilemaps.tscn")
const CROSSER = preload("res://Crosser/crosser.tscn")
const DUMP = preload("res://Dumpster/dumpster.tscn")
const BORDER = preload("res://Level/border.tscn")
const LINE = preload("res://lineofdeath/lineofdeath.tscn")
const POP = preload("res://menus/GameUI/popups.tscn")
const EXPLBARREL = preload("res://Barrel/exploding_barrel.tscn")
const SHIELD = preload("res://Shield/shieldbattery.tscn")
const ITEMLABELS = preload("res://Items/itemlabels.tscn")
const DEFEAT = preload("res://menus/GameUI/game_over.tscn")
const PAUSE = preload("res://menus/GameUI/pause_panel.tscn")


# spawning
#var ITEM_LIST = []
#var BARRELS = []
@onready var BORDERS = []
@onready var TERRAIN = []
#var num_items = 5
@onready var dashpopup = true 
@onready var line = null
# randomization
#const ITEM_NAME_LIST = ['0', '1', '2', '3']
#var TERRAIN_LIST =['0', '1']

var sidewalk = false

var iconlabels = ITEMLABELS.instantiate()
var playerspeedicon = iconlabels.get_node("PlayerSpeedVbox").duplicate()
var carspeedicon = iconlabels.get_node("CarSpeedVbox").duplicate()
var dashicon = iconlabels.get_node("DashVbox").duplicate()
var carspacingicon = iconlabels.get_node("CarSpacingVbox").duplicate()

@onready var hboxlabels = $CanvasLayer/HBoxContainer 
#var verticalseperator = VSeparator.new()

	
func itemSpawn():
	
	# at least one space must be open
	var open  = randi_range(0, 14)
	
	# 80% of tiles blank 9% barrels
	# 5% dumpsters 4% items 1% explosive
	var i = 0;
	while i < 15:
		var chance = randf_range(0,99)
		var dir = "spawnterrain/Node" + str(i)
		
		if chance < 80 || i == open:
			pass
		elif chance < 89:
			var barrel = BARREL.instantiate().duplicate()
			barrel.visible = true
			barrel.position = get_node(dir).global_position
			$Ysort.add_child(barrel)
		elif chance < 90:
			var explbarrel = EXPLBARREL.instantiate().duplicate()
			explbarrel.visible = true
			explbarrel.position = get_node(dir).global_position
			$Ysort.add_child(explbarrel)
		elif chance < 95 && !(open in range(i + 1, i + 2)) && i < 12:
			var dump = DUMP.instantiate().duplicate()
			dump.visible = true
			dump.position = get_node(dir).global_position
			$Ysort.add_child(dump)
			i += 2
		else:
			var item_chance = randf_range(0,99)
			var item_num = 0
			var item
			if item_chance < 24:
				item_num = 0
			elif item_chance < 48:
				item_num = 1
			elif item_chance < 72:
				item_num = 2
			elif item_chance < 96:
				item_num = 3
			else:
				item_num = 4
				
			if item_num == 4:
				item = SHIELD.instantiate().duplicate()
			else:
				item = ITEM.instantiate().get_node("Node" + str(item_num)).duplicate()
			item.visible = true
			item.position = get_node(dir).global_position
			$Ysort.add_child(item)
		
		i += 1
	
func carSpawn():
	var car = CAR.instantiate().duplicate()
	car.position.y = $spawnterrain/Node0.global_position.y - 5
	car.visible = true
	
	var side = randi_range(0,1)
	if side == 0:
		car.position.x = Global.despawn_left
	else:
		car.position.x = Global.despawn_right
		
	$Ysort.add_child(car)

func firstTerrainSpawn(xpos, ypos):
#	var tile_num = randi_range(0,1)
	sidewalk = true
	var tile = TILES.instantiate().get_node("TileMap0").duplicate()
	tile.position.x = xpos
	tile.position.y = ypos
	tile.visible = true
	TERRAIN.append(tile) 
	$spawnterrain.global_position.y -= 144
	
	$Tiles.add_child(tile)
	
func terrainSpawn(type, xpos, ypos):
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
	
func _input(event):
	if event.is_action_pressed("down_s")\
	|| event.is_action_pressed("up_w")\
	|| event.is_action_pressed("left_a")\
	|| event.is_action_pressed("right_d"):
		$CanvasLayer/Instructions.visible = false
		Global.input_active = true
	elif event.is_action_released("down_s")\
	|| event.is_action_released("up_w")\
	|| event.is_action_released("left_a")\
	|| event.is_action_released("right_d"):
		Global.input_active = false
	
func terrainSpawnLogic():
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

func update_labels():
	if Global.updatelabels:
		Global.updatelabels = false
		if Global.playerspeedlabelon:
			hboxlabels.add_child(playerspeedicon)
			Global.playerspeedlabelon = false
		if Global.carspeedlabelon:
			hboxlabels.add_child(carspeedicon)
			Global.carspeedlabelon = false
		if Global.dashlabelon:
			hboxlabels.add_child(dashicon)
			Global.dashlabelon = false
		if Global.carspacinglabelon:
			hboxlabels.add_child(carspacingicon)
			Global.carspacinglabelon = false
		
		playerspeedicon.get_node("PlayerSpeed").text = str(Global.player_speed_mod)
		carspeedicon.get_node("CarSpeed").text = str(Global.car_speed_mod)
		dashicon.get_node("Dash").text = str(Global.dash_mod)
		carspacingicon.get_node("CarSpacing").text = str(Global.timer_mod)

func dash_check():
	if Global.dash && dashpopup: 
		dashpopup = false
		var dash_pop_up = POP.instantiate()
		$CanvasLayer.add_child(dash_pop_up)

func terrain_check():
	if Global.spawnTerrain:
		$CanvasLayer/Score.text = "Score " + str(Global.score)
		Global.spawnTerrain = false
		terrainSpawnLogic()
		Global.incrementDifficulty(2)
		if Global.score % 100 == 0:
			spawnBorder(960, Global.player_pos_y)

@warning_ignore("unused_parameter")
func _process(delta):
	update_labels()
	dash_check()
	terrain_check()

func spawnBorder(x, y):
	var border = BORDER.instantiate().duplicate()
	border.position.x = x
	border.position.y = y
#	print(border.global_position)
	BORDERS.append(border)
	$border.add_child(border)
	if BORDERS.size() > 1:
		BORDERS[0].queue_free()
		BORDERS.remove_at(0)

func spawnLineOfDeath():
	line = LINE.instantiate()
	line.position.x = 0
	line.position.y = 1500
	$lineofdeath.add_child(line)

func loadDefeat():
	var losepopup = DEFEAT.instantiate().duplicate()
	losepopup.visible = false
	$CanvasLayer.add_child(losepopup)
	Global.game_over_pop_up = losepopup

func loadPause():
	var pausepopup = PAUSE.instantiate().duplicate()
	pausepopup.visible = false
	$CanvasLayer.add_child(pausepopup)
	Global.pause_popup = pausepopup

func _ready():
	#load pause and game over menu
	loadDefeat()
	loadPause()
	#player
	var player = CROSSER.instantiate()
	player.position.x = $PlayerStart.global_position.x
	player.position.y = $PlayerStart.global_position.y
	Global.player_pos_x = player.position.x
	Global.player_pos_y = player.position.y
	$PlayerStart.queue_free()
	player.visible = true
	$Ysort.add_child(player)
	# level
	spawnBorder(960, Global.player_pos_y)
	firstTerrainSpawn(0, $spawnterrain.global_position.y)
	for i in 18:
		terrainSpawnLogic()
	$CanvasLayer/Score.text = "Score " + str(Global.score)
	# lineofdeath
	spawnLineOfDeath()
	#labels

