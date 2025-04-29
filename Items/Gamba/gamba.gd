extends Node

@export var item_pool : Array = []
@export var gamba_resut_time_seconds : int = 5
@onready var cycleitemcounter : int = 0
@onready var itemcycletimer : Timer = $HBoxContainer/ItemCycleTimer
@onready var numofcycles : int = len(item_pool) - 1
@onready var timepercycle : float =  gamba_resut_time_seconds / float(numofcycles)
@onready var timepoeritemcycle : float = timepercycle / numofcycles

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	itemcycletimer.start(timepoeritemcycle)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_item_cycle_timer_timeout() -> void:
	var len_item_pool : int = len(item_pool)
	
	if len_item_pool < 2:
		present_winner()
		return
	
	cycleitemcounter += 1
	if cycleitemcounter == numofcycles:
		numofcycles -= 1
		cycleitemcounter = 0
		
		item_pool.remove_at(randi_range(0, len_item_pool - 1))
		if len_item_pool < 2:
			present_winner()
			return
		
		item_pool.shuffle()
		timepoeritemcycle = timepercycle / len(item_pool)
		itemcycletimer.start(timepoeritemcycle)

func present_winner() -> void:
	pass
