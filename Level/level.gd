extends Node

const CAR = preload("res://Car/car.tscn")
const ITEM = preload("res://Items/items.tscn")
const BARREL = preload("res://Barrel/barrel.tscn")
const ITEM_NAME_LIST = ['0', '1', '2', '3']
var ITEM_LIST = []
var BARRELS = []
var num_items = 5
	
func itemSpawn():
	var current_item = ITEM_NAME_LIST[randi() % ITEM_NAME_LIST.size()]
	var item = ITEM.instantiate().get_node("Node" + str(current_item)).duplicate()
	item.visible = true
	$Ysort.add_child(item)
	ITEM_LIST.append(item)
	item.position.x = randi_range(42,1141)
	item.position.y = randi_range(-21,569)
	
func barrelSpawn(y):
	var barrel = BARREL.instantiate().duplicate()
	barrel.visible = true
	$Ysort.add_child(barrel)
	BARRELS.append(barrel)
	barrel.position.x = randi_range(42,1141)
	barrel.position.y =  y
	
func carSpawn(start_pos):
	var car = CAR.instantiate()
	var car_start_node_name = "StartPositions/CarStart" + str(start_pos)
	car.position = get_node(car_start_node_name).position
	$Ysort.add_child(car)
	var timer_node_name = "CarTimers/Timer" + str(start_pos)
	# make sure variation does not go past each other
	var timerL = Global.timer_l
	var timerH = Global.timer_h
	if timerL > timerH:
		get_node(timer_node_name).wait_time = timerL
	else:
		get_node(timer_node_name).wait_time = randf_range(timerL, timerH)

func spawn_items(num):
	for i in num:
		itemSpawn()

func _input(event):
	if event.is_action_pressed("down_s")\
	|| event.is_action_pressed("up_w")\
	|| event.is_action_pressed("left_a")\
	|| event.is_action_pressed("right_d"):
		$CanvasLayer/Instructions.visible = false
#	if event.is_action_pressed("start_game"):
#		print("car, player, variation, timeL, timeH")
#		print(Global.car_speed_scaling)
#		print(Global.player_speed_scaling)
#		print(Global.variation_scaling)
#		print(Global.timer_l)
#		print(Global.timer_h)
#		Global.incrementDifficulty()
#		Global.score += 1


@warning_ignore("unused_parameter")
func _process(delta):
#	print(Global.car_speed_scaling)
#	print($Ysort/player/crosser.position)
	if $Ysort/player/crosser.position.y < -200: 
		for i in ITEM_LIST:
			if i != null: i.queue_free()
		ITEM_LIST = []
		for i in BARRELS:
			if i != null: i.queue_free()
		BARRELS = []
		spawn_items(num_items)
		barrelSpawn(600)
		barrelSpawn(383)
		barrelSpawn(160)
		barrelSpawn(-62)
		$Ysort/player/crosser.position = $Ysort/player/PlayerStart.position
		Global.score += 1
		Global.incrementDifficulty()
#		Global.player_base_speed = Global.player_base_speed
#		Global.car_base_speed = Global.car_base_speed + 10*(log(Global.score) / log(10))
#		Global.car_base_speed = Global.car_base_speed + 10*(log(Global.score) / log(10))
	$CanvasLayer/Score.text = "Score: " + str(Global.score)
	
func _on_timer_1_timeout(): carSpawn(1)
func _on_timer_2_timeout(): carSpawn(2)
func _on_timer_3_timeout(): carSpawn(3)
func _on_timer_4_timeout(): carSpawn(4)
func _on_timer_5_timeout(): carSpawn(5)
func _on_timer_6_timeout(): carSpawn(6)

func _ready():
	$CanvasLayer/Score.text = "Score: " + str(Global.score)
#	$CanvasLayer/Instructions.visible = true
	spawn_items(num_items)
	carSpawn(1)
	carSpawn(2)
	carSpawn(3)
	carSpawn(4)
	carSpawn(5)
	carSpawn(6)
	barrelSpawn(600)
	barrelSpawn(383)
	barrelSpawn(160)
	barrelSpawn(-62)



