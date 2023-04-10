extends Area2D

const CAR_LIST = ['Grey1', 'Grey2', 'Yellow1', 'Yellow2']
var direction = 1
var car_speed = Global.car_base_speed
var car_speed_l = car_speed
var car_speed_h = car_speed
func _ready():
	car_speed_l = (Global.car_speed_scaling*0.9)/Global.variation_scaling
	car_speed_h = (Global.car_speed_scaling*1.1)*Global.variation_scaling
#	randomize()
	var current_car = CAR_LIST[randi() % CAR_LIST.size()]
	$AnimatedSprite2D.animation = current_car
	if current_car in ['Yellow1', 'Yellow2']:
		$CollisionShape2DYellow.set_deferred("disabled", false)
	else:
		$CollisionShapeGrey.set_deferred("disabled", false)
	# make sure variation does not go past each other
	if car_speed_l > car_speed_h:
		car_speed = car_speed_l
	else:
		car_speed = randf_range(car_speed_l, car_speed_h)
	
	if global_position.x < 0: 
		direction = -1
		$AnimatedSprite2D.flip_h = true
	else: direction = 1

@warning_ignore("unused_parameter")
func _process(delta):
	if global_position.x > 1500 || global_position.x < -350:
		queue_free()
	position.x -= car_speed * delta * direction


@warning_ignore("unused_parameter")
func _on_body_entered(body):
	get_tree().change_scene_to_file("res://GameUI/game_ui.tscn")
