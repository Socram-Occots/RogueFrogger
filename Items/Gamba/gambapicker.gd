extends Node

@export var item_pool : Array = []
@export var gamba_result_time_seconds : int = 5
@onready var cycleitemcounter : int = 0
@onready var itemcycletimer : Timer = $HBoxContainer/ItemCycleTimer
@onready var gamba_rect: TextureRect = $HBoxContainer/GambaRect
@onready var h_box_container: HBoxContainer = $HBoxContainer
@onready var label: Label = $HBoxContainer/Label
@onready var timepercycle : float  
@onready var timeperitemcycle : float
@onready var len_item_pool : int = len(item_pool)
@onready var total_sec : float = 0
@onready var temp_item_pool : Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	h_box_container.visible = false
	set_process(false) 
	  
func begin_gamba() -> void:
	if len_item_pool < 1:
		return
	set_process(true)
	temp_item_pool = item_pool.duplicate()
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
	
	var multi_result : int = Global.gamba_mod * Global.follower_spawn_multi
	
	match temp_item_pool[cycleitemcounter][0]:
		"PlayerSpeed": Global.inc_PlayerSpeed(multi_result)
		"GlideBoots": Global.inc_GlideBoots(multi_result)
		"Dash": Global.inc_Dash(multi_result)
		"expl_B": Global.inc_expl_B(multi_result)
		"GrappleRope": Global.inc_GrappleRope(multi_result)
		"Follower": Global.inc_Follower(Global.gamba_mod)
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
	
