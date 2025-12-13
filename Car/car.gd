extends Area2D

const CAR_LIST : Array[String] = ['Grey1', 'Grey2', 'colors', "Yellow1", 'Yellow2', "motorcycle"]
const CAR_COLORS : Array[String] = ["red", "blue", "green", "cyan", "purple", "pink"]
const MOTORC_COlORS : Array[String] = ["red", "blue", "green", "yellow", "cyan", "purple", "orange"]
var no_ignore : bool = false
var car_speed : float = 0
var direction : int = 0
#var current_car = ""
@onready var rectangleGrey: Rectangle = $CollisionShapeGrey/Rectangle
@onready var rectangleYellow: Rectangle = $CollisionShape2DYellow/Rectangle
@onready var rectangleColor: Rectangle = $CollisionShape2Dcolor/Rectangle
@onready var rectangleMotor: Rectangle = $CollisionShape2Dmotorcycle/Rectangle



func _ready():
	set_meta("Car", false)
	$CollisionShapeGrey.set_deferred("disabled", true)
	$CollisionShape2DYellow.set_deferred("disabled", true)
	$CollisionShape2Dmotorcycle.set_deferred("disabled", true)
	$CollisionShape2Dcolor.set_deferred("disabled", true)
	$AnimatedSprite2DMotorcycle.visible = false
	$AnimatedSprite2D.visible = false
	rectangleGrey.visible = false
	rectangleYellow.visible = false
	rectangleColor.visible = false
	rectangleMotor.visible = false
	rectangleGrey.size.y = 47
	rectangleYellow.size.y = 45
	rectangleMotor.size.y = 8
	rectangleColor.size.y = 40
	
	
	if has_meta("speed"):
		no_ignore = true
		car_speed = self.get_meta("speed")
		direction = self.get_meta("direction")
#	randomize()
	var current_car : String = CAR_LIST[GRand.maprand.randi() % CAR_LIST.size()]
	
	var visible_hitbox : bool = SettingsDataContainer.get_show_hitboxes()
	
	if current_car == "motorcycle":
		$AnimatedSprite2DMotorcycle.visible = true
		$AnimatedSprite2DMotorcycle.animation = MOTORC_COlORS[
			GRand.maprand.randi() % MOTORC_COlORS.size()]
		$CollisionShape2Dmotorcycle.set_deferred("disabled", false)
		rectangleMotor.visible = visible_hitbox
	else:
		$AnimatedSprite2D.visible = true
		if current_car == "colors":
			$AnimatedSprite2D.animation = CAR_COLORS[
				GRand.maprand.randi() % CAR_COLORS.size()]
			$CollisionShape2Dcolor.set_deferred("disabled", false)
			rectangleColor.visible = visible_hitbox
		else:
			$AnimatedSprite2D.animation = current_car
		if current_car in ["Yellow1", "Yellow2"]:
			$CollisionShape2DYellow.set_deferred("disabled", false)
			rectangleYellow.visible = visible_hitbox
		elif current_car in ['Grey1', 'Grey2']:
			$CollisionShapeGrey.set_deferred("disabled", false)
			rectangleGrey.visible = visible_hitbox

@warning_ignore("unused_parameter")
func _physics_process(delta) -> void:
	if no_ignore:
		position.x -= car_speed * delta * direction


@warning_ignore("unused_parameter")
func _on_body_entered(body):
#	print(current_car)
	var metalist : PackedStringArray = body.get_meta_list()
	if "Player" in metalist:
#		print("car")
		if !body.shield_up:
			Global.defeat()
		else:
			body.shield_comp = true
	elif "Follower" in metalist:
		body.remove_follower()
	
func _on_body_exited(body):
	var metalist : PackedStringArray = body.get_meta_list()
	if "Player" in metalist && body.shield_up:
		body.shield_gone = true
		body.shield_comp = false
