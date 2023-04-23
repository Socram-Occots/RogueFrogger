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
	
	player_animation()
	move_and_slide()
	
	
	
	
func player_animation():
#	$"AnimatedSprite2D".flip_h = false
	if animated.flip_h: animated.flip_h = (velocity.y == 0 && velocity.x < 0)
	if velocity == Vector2.ZERO: animated.play("stand")
	elif velocity.y > 0: animated.play("walk_down")
	elif velocity.y < 0: animated.play("walk_up")
	elif velocity.x < 0: animated.play("walk_side")
	else: 
		animated.play("walk_side")
		animated.flip_h = true
#	elif velocity.x > 0:
#		$"AnimatedSprite2D".play("walk_side")
		



