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
const POP = preload("res://GameUI/popups.tscn")
const EXPLBARREL = preload("res://Barrel/exploding_barrel.tscn")

# spawning
#var ITEM_LIST = []
#var BARRELS = []
@onready var BORDERS = []
@onready var TERRAIN = []
#var num_items = 5
@onready var dashpopup = true 

# randomization
#const ITEM_NAME_LIST = ['0', '1', '2', '3']
#var TERRAIN_LIST =['0', '1']

var sidewalk = false;
	
func itemSpawn():
	
	# at least one space must be open
	var open  = randi_range(0, 19)
	
	# 80% of tiles blank 7.5% barrels
	# 7.5% dumpsters 5% items
	var i = 0;
	while i < 20:
		var chance = randf_range(0,99)
		var dir = "spawnterrain/Node" + str(i)
		
		if chance < 80 || i == open:
			pass
		elif chance < 87.5:
			var barrel = BARREL.instantiate().duplicate()
			barrel.visible = true
			barrel.position = get_node(dir).global_position
			$Ysort.add_child(barrel)
		elif chance < 93:
			var explbarrel = EXPLBARREL.instantiate().duplicate()
			explbarrel.visible = true
			explbarrel.position = get_node(dir).global_position
			$Ysort.add_child(explbarrel)
		elif chance < 95 && !(open in range(i + 1, i + 3)) && i < 18:
			var dump = DUMP.instantiate().duplicate()
			dump.visible = true
			dump.position = get_node(dir).global_position
			$Ysort.add_child(dump)
			i += 3
		else:
			var item_num = randi_range(0,3)
			var item = ITEM.instantiate().get_node("Node" + str(item_num)).duplicate()
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
		car.position.x = -128 #-128
	else:
		car.position.x = 1408 #1408
		
	$Ysort.add_child(car)
	

func firstTerrainSpawn(xpos, ypos):
#	var tile_num = randi_range(0,1)
	sidewalk = true
	var tile = TILES.instantiate().get_node("TileMap0").duplicate()
	tile.position.x = xpos
	tile.position.y = ypos
	tile.visible = true
	TERRAIN.append(tile) 
	$spawnterrain.global_position.y -= 96
	
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
	
	$spawnterrain.global_position.y -= 96
	
func _input(event):
	if event.is_action_pressed("down_s")\
	|| event.is_action_pressed("up_w")\
	|| event.is_action_pressed("left_a")\
	|| event.is_action_pressed("right_d"):
		$CanvasLayer/Instructions.visible = false
		$CanvasLayer/Items.visible = true
#	if event.is_action_released("dash"):
#		print(Global.car_speed_scaling)
		
func terrainSpawnLogic():
	if sidewalk:
		terrainSpawn(1, 0, $spawnterrain.global_position.y)
	else:	
		var tile_num = randi_range(0,1)
		terrainSpawn(tile_num, 0, $spawnterrain.global_position.y)
		
#	print(TERRAIN[0].global_position.y)
#	print(Global.player_pos_y)
	if !TERRAIN.is_empty() && TERRAIN[0].global_position.y - Global.player_pos_y > 888:
		TERRAIN[0].queue_free()
		TERRAIN.remove_at(0)

@warning_ignore("unused_parameter")
func _process(delta):
	$CanvasLayer/Items/PlayerSpeed.text = str(Global.player_speed_mod)
	$CanvasLayer/Items/CarSpeed.text = str(Global.car_speed_mod)
	$CanvasLayer/Items/Dash.text = str(Global.dash_mod)
	$CanvasLayer/Items/CarSpacing.text = str(Global.timer_mod)
	if Global.dash && dashpopup: 
		dashpopup = false
		var dash_pop_up = POP.instantiate()
		$CanvasLayer.add_child(dash_pop_up)
	if Global.spawnTerrain:
		$CanvasLayer/Score.text = "Score " + str(Global.score)
		Global.spawnTerrain = false
		terrainSpawnLogic()
		Global.incrementDifficulty(2)
		if Global.score % 100 == 0:
			spawnBorder(640, Global.player_pos_y)

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

func _ready():
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
	spawnBorder(640, Global.player_pos_y)
	firstTerrainSpawn(0, $spawnterrain.global_position.y)
	for i in 18:
		terrainSpawnLogic()
	$CanvasLayer/Score.text = "Score " + str(Global.score)
	# lineofdeath
	var line = LINE.instantiate()
	line.position.x = 0
	line.position.y = 720
	$lineofdeath.add_child(line)
	
	
