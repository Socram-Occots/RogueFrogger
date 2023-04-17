extends Node2D

var car_speed = Global.car_base_speed
var car_speed_l = car_speed
var car_speed_h = car_speed

func _ready():
	car_speed_l = (Global.car_speed_scaling*0.7)/Global.variation_scaling
	car_speed_h = (Global.car_speed_scaling*1.3)*Global.variation_scaling
		
	if car_speed_l > car_speed_h:
		car_speed = car_speed_l
	else:
		car_speed = randf_range(car_speed_l, car_speed_h)
		
	$car.set_meta("speed", car_speed)
	var auto = $car.duplicate()
	auto.visible = true
	$cars.add_child(auto)
	$Timer.wait_time = randf_range(Global.timer_l, Global.timer_h)

@warning_ignore("unused_parameter")
func _process(delta):
	if global_position.y - Global.player_pos_y > 777:
		queue_free()

func _on_timer_timeout():
	var auto = $car.duplicate()
	auto.visible = true
	$cars.add_child(auto)
