extends CharacterBody2D

@onready var candash : bool = true
@onready var dashing : bool = false
@onready var dashcooldown : bool = true
@onready var shield_up : bool = false
@onready var shield_comp : bool = false
@onready var shield_ready : bool = true
@onready var shield_gone : bool = false
@onready var animated : AnimatedSprite2D = $"playermove"
@onready var shieldAnimation : AnimatedSprite2D = $shield


func _ready():
	# stop camera from being weird initially
	$Camera2D.reset_smoothing()
	
	shieldAnimation.visible = false
	shieldAnimation.stop()
	shieldAnimation.animation = "shield"
	shieldAnimation.frame = 0
	# this will be an option for camera smoothing
	#$Camera2D.position_smoothing_enabled = true
	#$Camera2D.limit_smoothed = true
	

func move_player() -> void:
	if Input.is_action_pressed("left_a"):
		velocity.x -= 1
	if Input.is_action_pressed("right_d"):
		velocity.x += 1
	if Input.is_action_pressed("down_s"):
		velocity.y += 1
	if Input.is_action_pressed("up_w"):
		velocity.y -= 1
	velocity = velocity.normalized() * Global.player_speed_scaling

	if Input.is_action_pressed("walk"):
		velocity /= 2


func _on_cooldown_timeout():
	dashcooldown = true

@warning_ignore("unused_parameter")
func _process(delta):
#	print(global_position)
	Global.player_pos_x = global_position.x
	Global.player_pos_y = global_position.y
#	if Input.is_action_pressed("ui_copy"): print(position)
	
	if Input.is_action_just_pressed("dash") && Global.dash && dashcooldown && velocity != Vector2.ZERO && candash:
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
		var vLength : float = sqrt(pow(velocity.x, 2) + pow(velocity.y, 2))
		animated.speed_scale = vLength/Global.player_base_speed

	player_animation()
	move_and_slide()
	
	# checking player shield
	player_shield()
	shield_compromised()
	
	# tracking velocity for rigidbodies
	if velocity == Vector2.ZERO:
		await get_tree().create_timer(0.1).timeout
		Global.player_prev_vel = Vector2.ZERO
	
func player_animation() -> void:
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
		

func player_shield() -> void:
	if shield_ready && shield_up:
		shieldAnimation.visible = true
		shieldAnimation.play("shield")
		shield_ready = false
		
func shield_compromised() -> void:
	if shield_comp:
#		print("shield_comp true")
		shieldAnimation.modulate = "ff0000"
		
	elif !shield_comp && shield_gone:
		shieldAnimation.visible = false
		shieldAnimation.modulate = "ffffff"
		shield_up = false
		shield_ready = true
		shield_gone = false
#		print(shield_up)
		shieldAnimation.stop()
