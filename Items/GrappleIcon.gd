extends TextureRect


@onready var time_label : Label = $"../Sprite2D/MarginContainer/Label"
@onready var bar : TextureProgressBar = $"../Sprite2D/TextureProgressBar"
@onready var timer : Timer = $"../Sprite2D/TextureProgressBar/Timer"
@onready var on : bool = false
@onready var cool_down_time : float = Global.grapple_cool_down

func _ready():
	time_label.hide()
	bar.value = 0
	bar.hide()
	
@warning_ignore("unused_parameter")
func _process(delta):
	if Global.grapple_cool_down_bool && !on:
		grapple_activated()
	elif on:
		time_label.text = "%3.1f" % timer.time_left
		bar.value = int((timer.time_left / cool_down_time) * 100)
	
func grapple_activated():
	cool_down_time = Global.grapple_cool_down
	timer.start(cool_down_time)
	time_label.show()
	bar.show()
	on = true

func _on_timer_timeout():
	on = false
	bar.value = 0
	time_label.hide()
	bar.hide()
	Global.grapple_cool_down_bool = false
