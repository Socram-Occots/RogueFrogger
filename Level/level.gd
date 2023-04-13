extends Node

const CAR = preload("res://Car/car.tscn")
const ITEM = preload("res://Items/items.tscn")
const BARREL = preload("res://Barrel/barrel.tscn")
const TILES = preload("res://tilemaps/tilemaps.tscn")
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
	
	
func terrainSpawn(xpos, ypos):
	var tile_num = randi_range(0,1)
	var tile = TILES.instantiate().get_node("TileMap" + str(tile_num)).duplicate()
	tile.position.x = xpos
	tile.position.y = ypos
	tile.visible = true
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
		terrainSpawn($CanvasLayer/spawnterrain/Node1.global_position.x, 32)
		if !TERRAIN.is_empty():
			if TERRAIN[0] == null:
				TERRAIN.remove_at(0)
			elif TERRAIN[0].global_position.x - $Ysort/player.global_position.x > 850:
				TERRAIN[0].queue_free()
				TERRAIN.remove_at(0)

func _ready():
	pass
