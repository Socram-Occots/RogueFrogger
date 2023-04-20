extends CharacterBody2D

@onready var dash = $dash
@onready var dash_direction = 0;
@onready var candash = true
@onready var dashing = false
@onready var dashspeed = Global.dash_scaling
@onready var speed = Global.player_speed_scaling
@onready var dashtime = Global.dash_time

func move_player():
	dash_direction = 0;
	if Input.is_action_pressed("left_a"):
		velocity.x -= 1
		dash_direction = 1;
	if Input.is_action_pressed("right_d"):
		velocity.x += 1
		dash_direction = 2;
	if Input.is_action_pressed("down_s"):
		velocity.y += 1
		dash_direction = 3;
	if Input.is_action_pressed("up_w"):
		velocity.y -= 1
		dash_direction = 4;
		
	velocity = velocity.normalized() * Global.player_speed_scaling

func dash_player():
#	if dash_direction == 1 || dash_direction == 0:
#		velocity.x -= dashspeed
#	elif dash_direction == 2:
#		velocity.x += dashspeed
#	elif dash_direction == 3:
#		velocity.y += dashspeed
#	elif dash_direction == 4:
#		velocity.y -= dashspeed
	
	velocity *= Global.dash_scaling
	
	await get_tree().create_timer(dashtime).timeout
	dashspeed = Global.dash_scaling
	speed = Global.player_speed_scaling
	dashtime = Global.dash_time
	dashing = false
	candash = true
	

@warning_ignore("unused_parameter")
func _process(delta):
#	print(global_position)
	Global.player_pos_x = global_position.x
	Global.player_pos_y = global_position.y
#	if Input.is_action_pressed("ui_copy"): print(position)
	velocity = Vector2.ZERO
	
	if Input.is_action_just_pressed("dash") && candash:
		dashing = true
		candash = false
	
	move_player()
	
	if (dashing):
		dash_player()
	
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
		
