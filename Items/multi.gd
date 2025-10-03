extends Area2D

@export var cycletime : float = 3.0
@export var item_pool : Array = []
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var item_cycle_timer: Timer = $ItemCycleTimer
@onready var winner : int = 0
@onready var item_pool_len : int = 0
@onready var cycletimestep : float

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	var metalist : PackedStringArray = body.get_meta_list()
	for i in ["Player", "Follower"]:
		if i in metalist:
			var multi_result : int = 1 * Global.follower_mod
			match item_pool[winner][0]:
				"PlayerSpeed": Global.inc_PlayerSpeed(multi_result)
				"GlideBoots": Global.inc_GlideBoots(multi_result)
				"Dash": Global.inc_Dash(multi_result)
				"expl_B": Global.inc_expl_B(multi_result)
				"GrappleRope": Global.inc_GrappleRope(multi_result)
				"Follower": Global.inc_Follower(1)
				"Shrink": Global.inc_Shrink(multi_result)
				"Gamba": Global.inc_Gamba(multi_result)
				"Shield": Global.follower_array[0].shield_up = true
				"Slow": Global.inc_PlayerSlow(multi_result)
				"LongTeleport": Global.inc_LongTele(multi_result)
				"ShortTeleport": Global.inc_ShortTele(multi_result)
				"DVDBounce": Global.inc_DVD(multi_result)
				"Cleanse": Global.cleanse_curse(multi_result)
				"Grow": Global.inc_Grow(multi_result)
				_: print("Uknown item in the Multi:", item_pool[winner][0])
			queue_free()
			break

@warning_ignore("unused_parameter")
func _process(delta):
	pass

func _ready() -> void:
	if item_pool.is_empty():
		queue_free()
	item_pool_len = item_pool.size()
	sprite_2d.texture = item_pool[winner][1]
	cycletimestep = cycletime/item_pool.size()
	item_cycle_timer.start(cycletimestep)
	#print(item_pool_len)

func _on_item_cycle_timer_timeout() -> void:
	winner = (winner + 1) % item_pool_len
	sprite_2d.texture = item_pool[winner][1]
	item_cycle_timer.start(cycletimestep)
