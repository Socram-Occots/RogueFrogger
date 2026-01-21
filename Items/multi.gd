extends Item

@export var cycletime : float = 3.0
@export var item_pool : Array[Array] = []
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
				"PlayerSpeedMulti": Global.inc_PlayerSpeed(multi_result)
				"GlideBootsMulti": Global.inc_GlideBoots(multi_result)
				"DashMulti": Global.inc_Dash(multi_result)
				"expl_BMulti": Global.inc_expl_B(multi_result)
				"GrappleMulti": Global.inc_GrappleRope(multi_result)
				"FollowerMulti": Global.inc_Follower(1)
				"ShrinkMulti": Global.inc_Shrink(multi_result)
				"GambaMulti": Global.inc_Gamba(multi_result)
				"ShieldMulti": Global.follower_array[0].shield_up = true
				"SlowMulti": Global.inc_PlayerSlow(multi_result)
				"TeleportMulti": Global.inc_Tele(multi_result)
				"ItemTeleportMulti": Global.inc_ItemTele(multi_result)
				"DVDBounceMulti": Global.inc_DVD(multi_result)
				"CleanseMulti": Global.cleanse_curse(multi_result)
				"GrowMulti": Global.inc_Grow(multi_result)
				"HoleMulti": Global.inc_Hole(multi_result)
				_: print("Uknown item in the Multi:", item_pool[winner][0])
			queue_free()
			break

func _ready() -> void:
	defaultMeta()
	set_meta("Multi", false)
	if item_pool.is_empty():
		queue_free()
	item_pool_len = item_pool.size()
	sprite_2d.texture = item_pool[winner][1]
	cycletimestep = cycletime/item_pool.size()
	gracePeriod()
	item_cycle_timer.start(cycletimestep)
	#print(item_pool_len)

func _on_item_cycle_timer_timeout() -> void:
	winner = (winner + 1) % item_pool_len
	sprite_2d.texture = item_pool[winner][1]
	item_cycle_timer.start(cycletimestep)
