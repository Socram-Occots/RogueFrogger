extends TextureRect


@onready var time_label : Label = $"../Sprite2D/MarginContainer/Label"
@onready var bar : TextureProgressBar = $"../Sprite2D/TextureProgressBar"
@onready var timer : Timer = $"../Sprite2D/TextureProgressBar/Timer"
@onready var on : bool = false
@onready var cool_down_time : float = Global.longtele_cool_down
@onready var restart_ready : bool = false

func _ready():
	icon_activated()
	
@warning_ignore("unused_parameter")
func _process(delta):
	if on:
		time_label.text = "%3.1f" % timer.time_left
		bar.value = int((timer.time_left / cool_down_time) * 100)
	elif restart_ready && Global.longtele_mod > 0:
		restart_ready = false
		icon_activated()

func icon_activated():
	on = false
	bar.hide()
	time_label.hide()
	Global.teleportation_activated()
	if is_instance_valid($"."):
		await get_tree().create_timer(2.1375).timeout
	if is_instance_valid($"."):
		await get_tree().physics_frame
	if is_instance_valid($"."):
		await get_tree().physics_frame
	start_timer()

func start_timer() -> void:
	on = true
	timer.start(cool_down_time)
	time_label.show()
	bar.show()
	bar.value = 0

func _on_timer_timeout():
	Global.inc_LongTele(-1)
	on = false
	if Global.longtele_mod > 0:
		icon_activated()
	else:
		restart_ready = true
