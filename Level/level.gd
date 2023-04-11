extends Node

const CAR = preload("res://Car/car.tscn")
const ITEM = preload("res://Items/items.tscn")
const BARREL = preload("res://Barrel/barrel.tscn")
const ITEM_NAME_LIST = ['0', '1', '2', '3']
var ITEM_LIST = []
var BARRELS = []
var num_items = 5
	
func itemSpawn():
	
func barrelSpawn(y):
	
func carSpawn(start_pos):

func _input(event):
	if event.is_action_pressed("down_s")\
	|| event.is_action_pressed("up_w")\
	|| event.is_action_pressed("left_a")\
	|| event.is_action_pressed("right_d"):
		$CanvasLayer/Instructions.visible = false


@warning_ignore("unused_parameter")
func _process(delta):


func _ready():



