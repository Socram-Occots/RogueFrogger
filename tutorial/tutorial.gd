# tutorial.dg
extends "res://Level/level_gen.gd"

# importing
const DIALOG : Resource  = preload("res://Speech/dialoguefortutorial.dialogue")
const DIALOGBOX : Resource  = preload("res://Speech/balloon.tscn")
const TUTDONE : Resource  = preload("res://menus/GameUI/tutorial_over.tscn")
const BLINE : Resource  = preload("res://lineofdeath/lineofblocking.tscn")

#dialog
@onready var d_box : CanvasLayer = DIALOGBOX.instantiate()

# spawning

@onready var tutorial_state : int = 0
@onready var scorehidden : bool = true
@onready var tutorial_dialog : int = 0
@onready var tutorial_checkpoints : Array[int] = [0, 2, 5, 8, 11, 14, 17, 20, 999]
@onready var tutorial_sections : Array[String] = ['WELCOME', "BARREL", "SPEED", "CARSPEED", "DASH", "SPACING", "SHIELD", "FINAL", "FINAL"]
@onready var tutorial_index : int = 0
@onready var dialog = null
# randomization
#const ITEM_NAME_LIST = ['0', '1', '2', '3']
#var TERRAIN_LIST =['0', '1']

func tutorialItemSpawn() -> void:
	var i : int = 0
	var dir : String = "spawnterrain/Node" + str(i)
	match tutorial_state:
		0:
			dir = "spawnterrain/Node" + str(5)
			var barrel : StaticBody2D = BARREL.instantiate().duplicate()
			barrel.visible = true
			barrel.position = get_node(dir).global_position
			$Ysort.add_child(barrel)
			dir = "spawnterrain/Node" + str(6)
			var dumpster : StaticBody2D = DUMP.instantiate().duplicate()
			dumpster.visible = true
			dumpster.position = get_node(dir).global_position
			$Ysort.add_child(dumpster)
			dir = "spawnterrain/Node" + str(9)
			var explbarrel : RigidBody2D = EXPLBARREL.instantiate().duplicate()
			explbarrel.visible = true
			explbarrel.position = get_node(dir).global_position
			$Ysort.add_child(explbarrel)
		1:
			dir = "spawnterrain/Node" + str(7)
			var speed : Area2D = ITEM.instantiate().get_node("Node" + str(0)).duplicate()
			speed.visible = true
			speed.position = get_node(dir).global_position
			$Ysort.add_child(speed)
		2:
			dir = "spawnterrain/Node" + str(7)
			var carspeed : Area2D = ITEM.instantiate().get_node("Node" + str(1)).duplicate()
			carspeed.visible = true
			carspeed.position = get_node(dir).global_position
			$Ysort.add_child(carspeed)
		3:
			dir = "spawnterrain/Node" + str(7)
			var dashitem : Area2D = ITEM.instantiate().get_node("Node" + str(2)).duplicate()
			dashitem.visible = true
			dashitem.position = get_node(dir).global_position
			$Ysort.add_child(dashitem)
		4:
			dir = "spawnterrain/Node" + str(7)
			var carspace : Area2D = ITEM.instantiate().get_node("Node" + str(3)).duplicate()
			carspace.visible = true
			carspace.position = get_node(dir).global_position
			$Ysort.add_child(carspace)
		5:
			dir = "spawnterrain/Node" + str(7)
			var sheldy : Area2D = SHIELD.instantiate().duplicate()
			sheldy.visible = true
			sheldy.position = get_node(dir).global_position
			$Ysort.add_child(sheldy)

func tutorialTerrainSpawn(type : int, xpos : float, ypos : float) -> void:
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

func dialog_check() -> void:
	#start tutorial dialog
	#for simplicity, the list will end on a scenario that will never happen in the tutorial
	#thereby avoiding a crash
	if Global.score >= tutorial_checkpoints[tutorial_index]:
		d_box.start(DIALOG, tutorial_sections[tutorial_index])
		tutorial_index += 1

@warning_ignore("unused_parameter")
func _process(delta):
	update_labels()
	dash_check()
	terrain_tutorial_check()
	dialog_check()

func tutorialPath(x) -> void:
	tutorial_state = x
	for i in 3:
		firstTerrainSpawn(0, $spawnterrain.global_position.y)
	tutorialItemSpawn()

func blockBottom() -> void:
	var bline : StaticBody2D = BLINE.instantiate()
	bline.position.x = 0
	bline.position.y = 1250
	$lineofdeath.add_child(bline)

func spawn_finish_line() -> void:
	var finish_line : Node2D = CHECKERDLINE.instantiate()
	finish_line.position.x = 0
	finish_line.position.y = -4968
	$lineofdeath.add_child(finish_line)

func loadTutorialComplete() -> void:
	var tutorial_done : Control = TUTDONE.instantiate().duplicate()
	tutorial_done.visible = false
	$CanvasLayer.add_child(tutorial_done)
	Global.tutorial_over_pop_up = tutorial_done

func terrain_tutorial_check():
	if Global.spawnTerrain:
			Global.spawnTerrain = false
			$CanvasLayer/Score.text = "Score " + str(Global.score)
			terrainSpawnLogic()
			if Global.score % 100 == 0:
				spawnBorder(960, Global.player_pos_y)
			elif scorehidden && Global.score % 21 == 0:
				Global.score = 0
				scorehidden = false
				$CanvasLayer/Score.visible = true
				$CanvasLayer/Score.text = "Score 0"
				Global.car_speed_scaling = Global.car_base_speed
				Global.timer_l = Global.timer_base_l
				Global.timer_h = Global.timer_base_h
			elif !scorehidden && Global.score == 20:
				Global.tutorialDone()

func _ready():
	#load popups
	loadDefeat()
	loadPause()
	loadTutorialComplete()
	#add dialogbox 
	get_tree().current_scene.add_child(d_box)
	#hiding score at the beginning
	$CanvasLayer/Score.visible = false
	#player
	var player : RigidBody2D = CROSSER.instantiate()
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
	$CanvasLayer/Score.text = "Score " + str(Global.score)
	tutorialPath(0)
	tutorialPath(1)
	tutorialPath(2)
	tutorialPath(3)
	tutorialPath(4)
	tutorialPath(5)
	for i in 3:
		firstTerrainSpawn(0, $spawnterrain.global_position.y)
	blockBottom()

	spawn_finish_line()
	
