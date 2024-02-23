extends Node2D

var car_speed = Global.car_base_speed
var car_speed_l = car_speed
var car_speed_h = car_speed

func _ready():
	car_speed_l = (Global.car_speed_scaling*0.7)
	car_speed_h = (Global.car_speed_scaling*1.4)
		
	if car_speed_l > car_speed_h:
		car_speed = car_speed_l
	else:
		car_speed = randf_range(car_speed_l, car_speed_h)
		while (car_speed > Global.prev_car_speed*0.9 && car_speed < Global.prev_car_speed*1.2):
			car_speed = randf_range(car_speed_l, car_speed_h)
	
	Global.prev_car_speed = car_speed
	
	$car.set_meta("speed", car_speed)
	if global_position.x < 0: 
		$car.set_meta("direction", -1)
		$car/AnimatedSprite2D.flip_h = true
		$car/AnimatedSprite2DMotorcycle.flip_h = true
	else:
		$car.set_meta("direction", 1)
		
	var auto = $car.duplicate()
	auto.visible = true
	$cars.add_child(auto)
	$Timer.start(randf_range(Global.timer_l, Global.timer_h))

@warning_ignore("unused_parameter")
func _process(delta):
	if global_position.y - Global.player_pos_y > Global.despawn_lower:
		queue_free()

func _on_timer_timeout():
	var auto = $car.duplicate()
	auto.visible = true
	$cars.add_child(auto)
