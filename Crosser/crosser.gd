extends CharacterBody2D

#var speed = 250
#var dash_distance = 100

func _ready():
	position = $"../PlayerStart".position

@warning_ignore("unused_parameter")
func _process(delta):
#	print(position)
#	if Input.is_action_pressed("ui_copy"): print(position)
	velocity = Vector2.ZERO
	if Input.is_action_pressed("left_a"):
		velocity.x-= 1
	if Input.is_action_pressed("right_d"):
		velocity.x+= 1
	if Input.is_action_pressed("down_s"):
		velocity.y+= 1
	if Input.is_action_pressed("up_w"):
		velocity.y-= 1
	# scaling may change
	velocity = velocity.normalized() * Global.player_speed_scaling
	move_and_slide()
	player_animation()
	
func player_animation():
#	$"AnimatedSprite2D".flip_h = false
	if $"AnimatedSprite2D".flip_h: $"AnimatedSprite2D".flip_h = (velocity.y == 0 && velocity.x < 0)
	if velocity == Vector2.ZERO: $"AnimatedSprite2D".play("stand")
	elif velocity.y > 0: $"AnimatedSprite2D".play("walk_down")
	elif velocity.y < 0: $"AnimatedSprite2D".play("walk_up")
	elif velocity.x < 0: $"AnimatedSprite2D".play("walk_side")
	else: 
		$"AnimatedSprite2D".play("walk_side")
		$"AnimatedSprite2D".flip_h = true
#	elif velocity.x > 0:
#		$"AnimatedSprite2D".play("walk_side")
		
