extends TextureRect


@onready var time_label : Label = $"../Sprite2D/MarginContainer/Label"
@onready var bar : TextureProgressBar = $TextureProgressBar
@onready var timer : Timer = $"../Sprite2D/TextureProgressBar/Timer"
@onready var on : bool = false
@onready var cool_down_time : float = Global.tele_cool_down
@onready var crosser : RigidBody2D = Global.follower_array[0]
var added_to_tree : bool = false
var active : bool = true

func _ready() -> void:
	added_to_tree = true
	icon_activated()

@warning_ignore("unused_parameter")
func _process(delta) -> void:
	if on:
		time_label.text = "%3.1f" % timer.time_left
		bar.value = int((timer.time_left / cool_down_time) * 100)

func icon_activated() -> void:
	on = false
	bar.hide()
	time_label.hide()
	Global.follower_array[0].get_node("AnimationPlayer").play("teleport")
	await Global.secure_await_timer(Global.teleanilength)
	await Global.secure_await_phy_frame(2)
	if active && is_instance_valid(crosser):
		start_timer()
 
func start_timer() -> void:
	on = true
	cool_down_time = Global.tele_cool_down
	timer.start(cool_down_time)
	time_label.show()
	bar.show()
	bar.value = 0

func _on_timer_timeout() -> void:
	on = false
	if Global.tele_mod > 0:
		icon_activated()

func _on_teleport_vbox_tree_entered() -> void:
	if added_to_tree:
		active = true
		icon_activated()

func _on_teleport_vbox_tree_exiting() -> void:
	on = false
	active = false
	timer.stop()
	
