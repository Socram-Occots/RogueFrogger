extends TextureRect


@onready var time_label : Label = $"../Sprite2D/MarginContainer/Label"
@onready var bar : TextureProgressBar = $"../Sprite2D/TextureProgressBar"
@onready var timer : Timer = $"../Sprite2D/TextureProgressBar/Timer"
@onready var on : bool = false
@onready var cool_down_time : float = Global.longtele_cool_down

func _ready():
	icon_activated()
	
@warning_ignore("unused_parameter")
func _process(delta):
	if on:
		time_label.text = "%3.1f" % timer.time_left
		bar.value = int((timer.time_left / cool_down_time) * 100)
	elif Global.longtele_mod > 0:
		icon_activated()

func icon_activated():
	timer.start(cool_down_time)
	time_label.show()
	bar.show()
	bar.value = 0
	on = true
	teleportation_activated()

func _on_timer_timeout():
	Global.inc_LongTele(-1)
	if Global.longtele_mod == 0:
		on = false
		time_label.hide()
		bar.hide()
	else:
		icon_activated()

func teleportation_activated() -> void:
	Global.follower_array[0].rand_teleport(Vector2.ZERO)
