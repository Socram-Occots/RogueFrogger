extends CharacterBody2D

@onready var dash = $dash


@warning_ignore("unused_parameter")
func _process(delta):
#	print(global_position)
	Global.player_pos_x = global_position.x
	Global.player_pos_y = global_position.y
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
	
	velocity = Global.dash_scaling if dash.is_dashing() else velocity.normalized() * Global.player_speed_scaling
	
	if Input.is_action_just_pressed("dash"):
		dash.start_dash(Global.dash_scaling)

	
	player_animation()
	move_and_slide()
	
	
	
	
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
		
