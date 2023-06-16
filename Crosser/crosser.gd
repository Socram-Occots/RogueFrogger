extends CharacterBody2D

@onready var candash = true
@onready var dashing = false
@onready var dashcooldown = true
@onready var animated = $"AnimatedSprite2D"

func move_player():
	if Input.is_action_pressed("left_a"):
		velocity.x -= 1
	if Input.is_action_pressed("right_d"):
		velocity.x += 1
	if Input.is_action_pressed("down_s"):
		velocity.y += 1
	if Input.is_action_pressed("up_w"):
		velocity.y -= 1
	velocity = velocity.normalized() * Global.player_speed_scaling

	if Input.is_action_pressed("shift"):
		velocity /= 2


func _on_cooldown_timeout():
	dashcooldown = true

@warning_ignore("unused_parameter")
func _process(delta):
#	print(global_position)
	Global.player_pos_x = global_position.x
	Global.player_pos_y = global_position.y
#	if Input.is_action_pressed("ui_copy"): print(position)
	
	
	if Global.dash && dashcooldown && Input.is_action_just_pressed("dash") && velocity != Vector2.ZERO && candash:
#		print(Global.dash_scaling)
		Global.dash_cool_down_bool = true
		velocity *= Global.dash_scaling
		dashing = true
		candash = false
		await get_tree().create_timer(Global.dash_time).timeout
		dashing = false
		candash = true
		dashcooldown = false
		$Cooldown.start(Global.dash_cool_down)
		
	if (!dashing):
		velocity = Vector2.ZERO
		move_player()
	
	# tracking velocity for rigidbodies
	if velocity != Vector2.ZERO:
		Global.player_prev_vel = velocity
	
	player_animation()
	move_and_slide()
	
	# tracking velocity for rigidbodies
	if velocity == Vector2.ZERO:
		await get_tree().create_timer(0.1).timeout
		Global.player_prev_vel = Vector2.ZERO
	
func player_animation():
#	$"AnimatedSprite2D".flip_h = false
	if velocity == Vector2.ZERO: 
		animated.play("stand")
		animated.flip_h = false
	elif velocity.y > 0: 
		animated.play("walk_down")
		animated.flip_h = false
	elif velocity.y < 0: 
		animated.play("walk_up")
		animated.flip_h = false
	elif velocity.x < 0: 
		animated.play("walk_side")
		animated.flip_h = false
	else: 
		animated.play("walk_side")
		animated.flip_h = true
#	elif velocity.x > 0:
#		$"AnimatedSprite2D".play("walk_side")
		



