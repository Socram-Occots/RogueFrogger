extends Node

@export var item_pool : Array = []
@export var gamba_resut_time_seconds : int = 5
@onready var cycleitemcounter : int = 0
@onready var itemcycletimer : Timer = $HBoxContainer/ItemCycleTimer
@onready var gamba_rect: TextureRect = $HBoxContainer/GambaRect
@onready var timepercycle : float  
@onready var timeperitemcycle : float
@onready var len_item_pool : int = len(item_pool)
@onready var total_sec : float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	  
func begin_gamba() -> void:
	if len_item_pool < 1:
		return
	timepercycle = gamba_resut_time_seconds / float(len_item_pool - 1)
	timeperitemcycle = timepercycle / (len_item_pool)
	start_cycle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass


func _on_item_cycle_timer_timeout() -> void:
	cycleitemcounter += 1
	total_sec += timeperitemcycle
	
	if cycleitemcounter == len_item_pool:
		cycleitemcounter = 0
		item_pool.remove_at(randi_range(0, len_item_pool - 1))
		len_item_pool -= 1
		item_pool.shuffle()
		if len_item_pool > 1:
			timeperitemcycle = timepercycle / (len_item_pool)
	
	start_cycle()


func start_cycle() -> void:
	print("counter: ",cycleitemcounter,"timeperitemcycle: ",timeperitemcycle,"timepercycle: ",timepercycle)
	print(item_pool)
	print("item_count: ", len_item_pool)
	gamba_rect.texture = item_pool[cycleitemcounter]
	if len_item_pool < 2:
		present_winner()
		return

	itemcycletimer.start(timeperitemcycle)

func present_winner() -> void:
	print("winner!:", item_pool[cycleitemcounter])
	print("sec: ", total_sec)
	gamba_rect.texture = item_pool[cycleitemcounter]
	await get_tree().create_timer(1).timeout
	#hidegambawheel
