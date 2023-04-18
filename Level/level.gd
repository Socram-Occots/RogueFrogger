extends Node

# importing
const CAR = preload("res://Car/car.tscn")
const ITEM = preload("res://Items/items.tscn")
const BARREL = preload("res://Barrel/barrel.tscn")
const TILES = preload("res://tilemaps/tilemaps.tscn")
const CROSSER = preload("res://Crosser/crosser.tscn")

# spawning
#var ITEM_LIST = []
#var BARRELS = []
var TERRAIN = []
var num_items = 5

# randomization
#const ITEM_NAME_LIST = ['0', '1', '2', '3']
#var TERRAIN_LIST =['0', '1']

var sidewalk = false;
	
func itemSpawn():
	
	# 80% of tiles are blank 15% of tiles have barrels 5% of tiles have items
	for i in 20:
		var chance = randf_range(0,99)
		var dir = "spawnterrain/Node" + str(i)
		if chance < 80:
			pass
		elif chance < 95:
			var barrel = BARREL.instantiate().duplicate()
			barrel.visible = true
			barrel.position = get_node(dir).global_position
			$Ysort.add_child(barrel)
		else:
			var item_num = randi_range(0,3)
			var item = ITEM.instantiate().get_node("Node" + str(item_num)).duplicate()
			item.visible = true
			item.position = get_node(dir).global_position
			$Ysort.add_child(item)
			
	
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
		
func terrainSpawnLogic():
	if sidewalk:
		terrainSpawn(1, 0, $spawnterrain.global_position.y)
	else:	
		var tile_num = randi_range(0,1)
		terrainSpawn(tile_num, 0, $spawnterrain.global_position.y)
		
#	print(TERRAIN[0].global_position.y)
#	print(Global.player_pos_y)
	if !TERRAIN.is_empty() && TERRAIN[0].global_position.y - Global.player_pos_y > 777:
		TERRAIN[0].queue_free()
		TERRAIN.remove_at(0)

@warning_ignore("unused_parameter")
func _process(delta):
	if Global.spawnTerrain:
		Global.spawnTerrain = false
		terrainSpawnLogic()
		
func _ready():
	var player = CROSSER.instantiate()
	player.position.x = $PlayerStart.global_position.x
	player.position.y = $PlayerStart.global_position.y
	Global.player_pos_x = player.position.x
	Global.player_pos_y = player.position.y
	$PlayerStart.queue_free()
	player.visible = true
	$Ysort.add_child(player)
	firstTerrainSpawn(0, $spawnterrain.global_position.y)
	for i in 9:
		terrainSpawnLogic()
