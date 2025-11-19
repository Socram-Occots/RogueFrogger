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
@onready var temp_item_pool : Array[Array]

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
	good_item_pool = GRand.shuffle_array(good_item_pool, 1)
	bad_item_pool = GRand.shuffle_array(bad_item_pool, 1)
	if good_item_pool_size < 2:
		temp_item_pool = good_item_pool
	else:
		temp_item_pool = good_item_pool.slice(0, 
			GRand.itemrand.randi_range(
				min(3, good_item_pool_size), good_item_pool_size))
	
	if bad_item_pool_size > 0:
		var bad_item_index_chance = GRand.itemrand.randi_range(
			0, bad_item_pool_size)
		if temp_item_pool.size() == 0:
			temp_item_pool += bad_item_pool.slice(
				0, max(2, bad_item_index_chance))
		elif bad_item_index_chance != 0:
			temp_item_pool += bad_item_pool.slice(0, bad_item_index_chance)
		elif temp_item_pool.size() == 1:
			temp_item_pool.append(
				bad_item_pool[GRand.itemrand.randi() % bad_item_pool_size])

	len_item_pool = temp_item_pool.size()
	
	timepercycle = gamba_result_time_seconds / float(len_item_pool - 1)
	timeperitemcycle = timepercycle / (len_item_pool)
	label.text = str(Global.gamba_mod) + "x"
	h_box_container.visible = true
	
	start_cycle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	label.text = str(Global.gamba_mod) + "x"


func _on_item_cycle_timer_timeout() -> void:
	cycleitemcounter += 1
	total_sec += timeperitemcycle
	
	if cycleitemcounter == len_item_pool:
		cycleitemcounter = 0
		temp_item_pool.remove_at(
			GRand.itemrand.randi_range(0, len_item_pool - 1))
		len_item_pool -= 1
		temp_item_pool = GRand.shuffle_array(temp_item_pool, 1)
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
	var multi_result : int = Global.gamba_mod
	await get_tree().create_timer(1).timeout
	
	match temp_item_pool[cycleitemcounter][0]:
		"PlayerSpeedGamba": Global.inc_PlayerSpeed(multi_result)
		"GlideBootsGamba": Global.inc_GlideBoots(multi_result)
		"DashGamba": Global.inc_Dash(multi_result)
		"expl_BGamba": Global.inc_expl_B(multi_result)
		"GrappleGamba": Global.inc_GrappleRope(multi_result)
		"FollowerGamba": Global.inc_Follower(multi_result)
		"ShrinkGamba": Global.inc_Shrink(multi_result)
		"SlowGamba": Global.inc_PlayerSlow(multi_result)
		"GrowGamba": Global.inc_Grow(multi_result)
		"LongTeleportGamba": Global.inc_LongTele(multi_result)
		"ShortTeleportGamba": Global.inc_ShortTele(multi_result)
		"CleanseGamba": Global.cleanse_curse(multi_result)
		"DVDBounceGamba": Global.inc_DVD(multi_result)
		"HoleGamba": Global.inc_Hole(multi_result)
		_: print("Uknown item in the Gamba Picker: ", temp_item_pool[cycleitemcounter][0])

	#reset length so gamba can function again
	len_item_pool = item_pool.size()
	Global.gamba_mod = 1
	#hidegambawheel and declare gamba not running again
	Global.gamba_running = false
	h_box_container.visible = false
	set_process(false)
	Global.gamba_done = false
	
