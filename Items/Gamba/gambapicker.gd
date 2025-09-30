extends Node

@export var item_pool : Array[Array] = []
@export var gamba_result_time_seconds : int = 5
@export var good_item_pool : Array[Array] = []
@export var bad_item_pool : Array[Array] = []
@onready var good_item_pool_size : int = good_item_pool.size()
@onready var bad_item_pool_size : int = bad_item_pool.size()
@onready var cycleitemcounter : int = 0
@onready var itemcycletimer : Timer = $HBoxContainer/ItemCycleTimer
@onready var gamba_rect: TextureRect = $HBoxContainer/GambaRect
@onready var h_box_container: HBoxContainer = $HBoxContainer
@onready var label: Label = $HBoxContainer/Label
@onready var timepercycle : float  
@onready var timeperitemcycle : float
@onready var len_item_pool : int = item_pool.size()
@onready var total_sec : float = 0
@onready var temp_item_pool : Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	h_box_container.visible = false
	set_process(false) 
	  
func begin_gamba() -> void:
	good_item_pool_size = good_item_pool.size()
	bad_item_pool_size = bad_item_pool.size()
	len_item_pool = good_item_pool_size + bad_item_pool_size
	if len_item_pool < 2:
		return
	set_process(true)
	good_item_pool.shuffle()
	bad_item_pool.shuffle()
	if good_item_pool_size < 2:
		temp_item_pool = good_item_pool
	else:
		temp_item_pool = good_item_pool.slice(0, 
		randi_range(min(3, good_item_pool_size), good_item_pool_size))
	
	if bad_item_pool_size > 1:
		var bad_item_index_chance = randi_range(0, bad_item_pool_size - 1)
		if bad_item_index_chance != 0:
			temp_item_pool += bad_item_pool.slice(0, bad_item_index_chance)
	
	len_item_pool = temp_item_pool.size()
	
	timepercycle = gamba_result_time_seconds / float(len_item_pool - 1)
	timeperitemcycle = timepercycle / (len_item_pool)
	label.text = str(Global.gamba_mod) + "x"
	h_box_container.visible = true
	
	start_cycle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	label.text = str(Global.gamba_mod) + "x"


func _on_item_cycle_timer_timeout() -> void:
	cycleitemcounter += 1
	total_sec += timeperitemcycle
	
	if cycleitemcounter == len_item_pool:
		cycleitemcounter = 0
		temp_item_pool.remove_at(randi_range(0, len_item_pool - 1))
		len_item_pool -= 1
		temp_item_pool.shuffle()
		if len_item_pool > 1:
			timeperitemcycle = timepercycle / (len_item_pool)
	
	start_cycle()


func start_cycle() -> void:
	#print("counter: ",cycleitemcounter,"timeperitemcycle: ",timeperitemcycle,"timepercycle: ",timepercycle)
	#print(temp_item_pool)
	#print("item_count: ", len_item_pool)
	gamba_rect.texture = temp_item_pool[cycleitemcounter][1]
	if len_item_pool < 2:
		present_winner()
		return

	itemcycletimer.start(timeperitemcycle)

func present_winner() -> void:
	Global.gamba_done = true
	#print("winner!:", temp_item_pool[cycleitemcounter])
	#print("sec: ", total_sec)
	gamba_rect.texture = temp_item_pool[cycleitemcounter][1]
	
	var multi_result : int = Global.gamba_mod * Global.follower_mod
	
	match temp_item_pool[cycleitemcounter][0]:
		"PlayerSpeed": Global.inc_PlayerSpeed(multi_result)
		"GlideBoots": Global.inc_GlideBoots(multi_result)
		"Dash": Global.inc_Dash(multi_result)
		"expl_B": Global.inc_expl_B(multi_result)
		"GrappleRope": Global.inc_GrappleRope(multi_result)
		"Follower": Global.inc_Follower(Global.gamba_mod)
		"Shrink": Global.inc_Shrink(multi_result)
		"Slow": Global.inc_PlayerSlow(multi_result)
		"Grow": Global.inc_Grow(multi_result)
		"LongTeleport": Global.inc_LongTele(multi_result)
		"ShortTeleport": Global.inc_ShortTele(multi_result)
		"Cleanse": Global.cleanse_curse(multi_result)
		"DVDBounce": Global.inc_DVD(multi_result)
		_: print("Uknown item in the Gamba Picker")
	
	await get_tree().create_timer(1).timeout
	#reset length so gamba can function again
	len_item_pool = len(item_pool)
	Global.gamba_mod = 1
	#hidegambawheel and declare gamba not running again
	Global.gamba_running = false
	h_box_container.visible = false
	set_process(false)
	Global.gamba_done = false
	
