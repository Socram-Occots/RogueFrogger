extends Area2D

const CAR_LIST = ['Grey1', 'Grey2', 'Yellow1', 'Yellow2']
var no_ignore = false
var car_speed = 0
var direction = 0

func _ready():
	if has_meta("speed"):
		no_ignore = true
		car_speed = self.get_meta("speed")
		direction = self.get_meta("direction")
#	randomize()
	var current_car = CAR_LIST[randi() % CAR_LIST.size()]
	$AnimatedSprite2D.animation = current_car
	
	if current_car in ['Yellow1', 'Yellow2']:
		$CollisionShape2DYellow.set_deferred("disabled", false)
	else:
		$CollisionShapeGrey.set_deferred("disabled", false)
	

@warning_ignore("unused_parameter")
func _process(delta):
	if no_ignore:
		if global_position.x > 2000 || global_position.x < -700:
			queue_free()
		position.x -= car_speed * delta * direction


@warning_ignore("unused_parameter")
func _on_body_entered(body):
	get_tree().change_scene_to_file("res://GameUI/game_ui.tscn")
