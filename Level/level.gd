extends Node

const CAR = preload("res://Car/car.tscn")
const ITEM = preload("res://Items/items.tscn")
const BARREL = preload("res://Barrel/barrel.tscn")
const TILES = preload("res://tilemaps/tilemaps.tscn")
const CROSSER = preload("res://Crosser/crosser.tscn")
const ITEM_NAME_LIST = ['0', '1', '2', '3']
var ITEM_LIST = []
var BARRELS = []
var TERRAIN_LIST =['0', '1']
var TERRAIN = []
var num_items = 5
	
func itemSpawn():
	pass
	
func barrelSpawn(y):
	pass
	
func carSpawn(start_pos):
	pass
	
	
func terrainSpawn(type, xpos, ypos):
#	var tile_num = randi_range(0,1)
	var tile = TILES.instantiate().get_node("TileMap" + str(type)).duplicate()
	tile.position.x = xpos
	tile.position.y = ypos
	tile.visible = true
	$spawnterrain.global_position.y -= 96
	$Tiles.add_child(tile)
	TERRAIN.append(tile)
	
func _input(event):
	if event.is_action_pressed("down_s")\
	|| event.is_action_pressed("up_w")\
	|| event.is_action_pressed("left_a")\
	|| event.is_action_pressed("right_d"):
		$CanvasLayer/Instructions.visible = false


@warning_ignore("unused_parameter")
func _process(delta):
	if (Global.spawnTerrain):
		Global.spawnTerrain = false
		var tile_num = randi_range(0,1)
		terrainSpawn(tile_num, 0, $spawnterrain.global_position.y)
		print(!TERRAIN.is_empty())
		print($Ysort/player.position.y)
		if !TERRAIN.is_empty():
			if TERRAIN[0] == null:
				TERRAIN.remove_at(0)
			elif TERRAIN[0].global_position.y - Global.player_pos_y > 850:
				TERRAIN[0].queue_free()
				TERRAIN.remove_at(0)
func _ready():
	var player = CROSSER.instantiate()
	player.position.x = $PlayerStart.global_position.x
	player.position.y = $PlayerStart.global_position.y
	player.visible = true
	$Ysort.add_child(player)
	terrainSpawn(1, 0, $spawnterrain.global_position.y)
