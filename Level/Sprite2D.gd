extends TextureRect


@onready var time_label = $"../Sprite2D/MarginContainer/Label"
@onready var bar = $"../Sprite2D/TextureProgressBar"
@onready var timer = $"../Sprite2D/TextureProgressBar/Timer"
@onready var on = false
@onready var cool_down_time = Global.dash_cool_down

func _ready():
	time_label.hide()
	bar.value = 0
	bar.hide()
	
@warning_ignore("unused_parameter")
func _process(delta):
	if Global.dash_cool_down_bool && !on:
		dash_activated()
	elif on:
		time_label.text = "%3.1f" % timer.time_left
		bar.value = int((timer.time_left / cool_down_time) * 100)
	
func dash_activated():
	cool_down_time = Global.dash_cool_down
	timer.start(cool_down_time)
	time_label.show()
	bar.show()
	on = true

func _on_timer_timeout():
	on = false
	bar.value = 0
	time_label.hide()
	bar.hide()
	Global.dash_cool_down_bool = false
