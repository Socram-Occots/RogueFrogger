extends TextureRect


@onready var bar : TextureProgressBar = $TextureProgressBar
@onready var timer : Timer = $TextureProgressBar/Timer
@onready var on : bool = false
@onready var cool_down_time : float = Global.hole_coyote_time

func _ready() -> void:
	bar.value = 0
	bar.hide()
	visible = false
	
@warning_ignore("unused_parameter")
func _process(delta) -> void:
	if Global.coyote_status_cool_down_bool:
		if !on:
			icon_activated()
		else:
			bar.value = int((timer.time_left / cool_down_time) * 100)
	elif on:
		icon_deactivated()

func icon_deactivated() -> void:
	bar.value = 0
	bar.hide()
	on = false
	timer.stop()
	Global.coyote_status_cool_down_bool = false
	visible = false

func icon_activated() -> void:
	cool_down_time = Global.hole_coyote_time
	timer.start(cool_down_time)
	bar.show()
	on = true
	visible = true

func _on_timer_timeout() -> void:
	on = false
	bar.value = 0
	bar.hide()
	Global.coyote_status_cool_down_bool = false
	visible = false
