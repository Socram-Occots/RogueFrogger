extends Node2D

var car_speed : float = Global.car_base_speed
var car_speed_l : float = car_speed
var car_speed_h : float = car_speed

func _ready():
	$car/CollisionShapeGrey.set_deferred("disabled", true)
	$car/CollisionShape2DYellow.set_deferred("disabled", true)
	$car/CollisionShape2Dmotorcycle.set_deferred("disabled", true)
	$car/CollisionShape2Dcolor.set_deferred("disabled", true)
	
	car_speed_l = (Global.car_speed_scaling*0.7)
	car_speed_h = (Global.car_speed_scaling*1.3)
	
	# this prevents the car's in each lane to be too squished
	if GRand.maprand.randi_range(0,1) == 0:
		# rolled low
		car_speed = GRand.maprand.randf_range(
			minf(Global.prev_car_speed*0.8, car_speed_l), 
			maxf(Global.prev_car_speed*0.8, car_speed_l))
	else :
		# rolled high
		car_speed = GRand.maprand.randf_range(
			minf(Global.prev_car_speed*1.2, car_speed_h), 
			maxf(Global.prev_car_speed*1.2, car_speed_h))
	
	Global.prev_car_speed = car_speed
	
	# set car spacing
	# we need it to not be too small
	var cross_gap_time : float = Global.player_width_px / car_speed
	
	var car_spacing_timer_l : float = cross_gap_time * 10
	var car_spacing_timer_h : float = cross_gap_time * 20
	
	#print(car_spacing_timer_l, car_spacing_timer_h)
	#print(car_speed)
	
	$car.set_meta("speed", car_speed)
	
	if global_position.x < 0: 
		$car.set_meta("direction", -1)
		$car/AnimatedSprite2D.flip_h = true
		$car/AnimatedSprite2DMotorcycle.flip_h = true
	else:
		$car.set_meta("direction", 1)
		
	var auto : Area2D = $car.duplicate()
	auto.visible = true
	$cars.add_child(auto)
	$Timer.start(GRand.maprand.randf_range(
		car_spacing_timer_l, car_spacing_timer_h))

func _on_timer_timeout():
	var auto : Area2D = $car.duplicate()
	auto.set_meta("Car", false)
	auto.visible = true
	$cars.add_child(auto)

@warning_ignore("unused_parameter")
func _on_despawn_trigger_area_entered(area: Area2D) -> void:
	queue_free()
