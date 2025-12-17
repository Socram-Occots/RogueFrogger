extends TextureRect


@onready var time_label : Label = $MarginContainer/Label
@onready var bar : TextureProgressBar = $TextureProgressBar
@onready var timer: Timer = $TextureProgressBar/Timer
@onready var on : bool = false
@onready var cool_down_time : float = Global.itemtele_cool_down
var added_to_tree : bool = false


func _ready():
	added_to_tree = true
	icon_activated()
	
@warning_ignore("unused_parameter")
func _process(delta):
	if on:
		time_label.text = "%3.1f" % timer.time_left
		bar.value = int((timer.time_left / cool_down_time) * 100)

func icon_activated():
	cool_down_time = Global.itemtele_cool_down
	timer.start(cool_down_time)
	time_label.show()
	bar.show()
	bar.value = 0
	on = true
	itemteleportation_activated()

func _on_timer_timeout():
	if Global.itemtele_mod == 0:
		on = false
		time_label.hide()
		bar.hide()
	else:
		icon_activated()

func itemteleportation_activated() -> void:
	Global.follower_array[0].rand_itemteleport()

func _on_item_teleport_vbox_tree_entered() -> void:
	if added_to_tree && !Global.follower_array.is_empty():
		await Global.follower_array[0].get_tree().physics_frame 
		icon_activated()

func _on_item_teleport_vbox_tree_exiting() -> void:
	on = false
