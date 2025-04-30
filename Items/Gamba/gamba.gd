extends Node

@export var item_pool : Array = []
@export var gamba_resut_time_seconds : int = 5
@onready var cycleitemcounter : int = 0
@onready var itemcycletimer : Timer = $HBoxContainer/ItemCycleTimer
@onready var timepercycle : float  
@onready var timeperitemcycle : float
@onready var len_item_pool : int = len(item_pool)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if len_item_pool < 1:
		return
	timepercycle = gamba_resut_time_seconds / float(len_item_pool - 1)
	timeperitemcycle = timepercycle / len_item_pool - 1
	start_cycle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_item_cycle_timer_timeout() -> void:
	cycleitemcounter += 1
	
	if cycleitemcounter == len_item_pool - 1:
		cycleitemcounter = 0
		item_pool.remove_at(randi_range(0, len_item_pool - 1))
		len_item_pool -= 1
		item_pool.shuffle()
		timeperitemcycle = timepercycle / len_item_pool - 1
	
	start_cycle()


func start_cycle() -> void:
	print(cycleitemcounter)
	
	if len_item_pool < 2:
		present_winner()
		return

	itemcycletimer.start(timeperitemcycle)

func present_winner() -> void:
	pass
