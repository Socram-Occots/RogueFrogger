extends StaticBody2D

@onready var not_moving = true
@onready var animationExplo = $RigidBody2D/AnimatedSprite2D

func _process(delta):
	if global_position.y - Global.player_pos_y > 777:
		queue_free()


func _on_body_entered(body):
	if not_moving && body.get_meta("Player"):
		velocity = body.velocity

func _ready():
	animationExplo.animation = "explosion"
	animationExplo.frame = 0
	
