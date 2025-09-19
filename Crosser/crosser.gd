extends RigidBody2D

const GRAPPLE : Resource = preload("res://Grapplerope/grapplerope.tscn")
const TELE : Resource = preload("res://Items/Teleport/teleportoutline.tscn")

@onready var candash : bool = true
@onready var dashing : bool = false
@onready var dashcooldown : bool = true
@onready var shield_up : bool = false
@onready var shield_comp : bool = false
@onready var shield_ready : bool = true
@onready var shield_gone : bool = false
@onready var grappling : bool = false
@onready var gliding : bool = false
@onready var glidethendashbonus : bool = false
@onready var animated : AnimatedSprite2D = $"playermove"
@onready var shieldAnimation : AnimatedSprite2D = $shield
@onready var glideBoots : ColorRect = $GlideBoots
@onready var velocityRigid : Vector2 = Vector2(0.0, 0.0)
@onready var velocityRigidDelta : Vector2 = Vector2(0.0, 0.0)
@onready var grapplehook : Line2D = GRAPPLE.instantiate()
@onready var vLength : float = 0
@onready var velocityGrapple : Vector2 = Vector2(0.0, 0.0)
@onready var grappled : bool = false
@onready var tele : Area2D = TELE.instantiate()

func _ready() -> void:
	# stop camera from being weird initially
	$Camera2D.reset_smoothing()
	
	#making sure sheild is reset
	shieldAnimation.visible = false
	shieldAnimation.stop()
	shieldAnimation.animation = "shield"
	shieldAnimation.frame = 0
	
	# making sure glideboots are reset
	glideBoots.visible = false
	
	# this will be an option for camera smoothing
	#$Camera2D.position_smoothing_enabled = true
	#$Camera2D.limit_smoothed = true
	
	# instantiate grapplie hook
	#grapplehook = GRAPPLE.instantiate()
	grapplehook.crosser = $"."

#func move_and_slide_rigidbody() -> void:
	#if !gliding:
		#apply_central_force(velocityRigid)

func move_player() -> void:
	if Input.is_action_pressed("left_a"):
		velocityRigid.x -= 1
	if Input.is_action_pressed("right_d"):
		velocityRigid.x += 1
	if Input.is_action_pressed("down_s"):
		velocityRigid.y += 1
	if Input.is_action_pressed("up_w"):
		velocityRigid.y -= 1
	
	var playerspeed_penalty : float = (1 - (Global.playerslow_percent *\
	(Global.playerslow_mod_real - 1)))
	
	velocityRigid = velocityRigid.normalized() *\
	Global.player_speed_scaling * playerspeed_penalty
	
	if Input.is_action_pressed("walk"):
		velocityRigid /= 2
		vLength = (Global.player_speed_scaling * playerspeed_penalty) / 2
	else:
		vLength = Global.player_speed_scaling * playerspeed_penalty

func dash_decision_tree() -> void:
	if Input.is_action_just_pressed("dash") && Global.dash &&\
	 !Global.dash_cool_down_bool && velocityRigid != Vector2.ZERO && candash:
#		print(Global.dash_scaling)
		Global.dash_cool_down_bool = true
		velocityRigid *= Global.dash_scaling
		velocityRigidDelta *= Global.dash_scaling
		dashing = true
		candash = false
		
		if gliding:
			glidethendashbonus = true
		
		await get_tree().create_timer(Global.dash_time).timeout
		dashing = false
		candash = true
		dashcooldown = false
		glidethendashbonus = false

func grapple_decision_tree() -> void:
	if Input.is_action_just_pressed("rope") && Global.grapple &&\
	 !Global.grapple_cool_down_bool && !grappling:
		Global.grapple_cool_down_bool = true
		grappling = true
		var grappledupe : Line2D = grapplehook.duplicate()
		grappledupe.dir_vector = velocityRigid.normalized()
		grappledupe.global_position = global_position
		grappledupe.crosser = $"."
		get_parent().add_child(grappledupe)

func glide_decision_tree() -> void:
	if Input.is_action_just_pressed("glide") && Global.glide:
		#Global.glide && !Global.glide_cool_down_bool &&
		if  !(Global.glide_cool_down_bool || gliding):
			Global.glide_cool_down_bool = true
			gliding = true
			animated.pause()
			glideBoots.visible = true
			await get_tree().create_timer(Global.glide_time).timeout
			gliding = false
			animated.play()
			glideBoots.visible = false
		elif gliding:
			gliding = false
			animated.play()
			glideBoots.visible = false
			
func movement_logic(delta : float) -> void:
	
	# this must go first because this what is updating velocityRigid
	if !(dashing || gliding):
		velocityRigid = Vector2.ZERO
		velocityRigidDelta = Vector2.ZERO
		move_player()
		velocityRigidDelta = velocityRigid * delta
	
		
	# tracking velocity for rigidbodies
	if velocityRigid != Vector2.ZERO:
		Global.player_prev_vel = velocityRigid
		animated.speed_scale = vLength/Global.player_base_speed

	if !gliding:

		# this sleeping line stops the player from sliding everywhere
		# the body stops sleeping once the character moves or gets hit
		sleeping = true
		
		player_animation()
		apply_central_force(velocityRigidDelta)
	elif glidethendashbonus:
		#this is to make sure the glidedash bonus is given only once
		glidethendashbonus = false
		apply_central_force(velocityRigidDelta)

@warning_ignore("unused_parameter")
func _process(delta : float) -> void:
	#print(global_position)
	Global.player_pos_x = global_position.x
	Global.player_pos_y = global_position.y
#	if Input.is_action_pressed("ui_copy"): print(position)
	
	dash_decision_tree()
	grapple_decision_tree()
	glide_decision_tree()
	
	movement_logic(delta)
	
	# checking player shield
	player_shield()
	shield_compromised()
	
	# tracking velocity for rigidbodies
	if velocityRigidDelta == Vector2.ZERO && Global.player_prev_vel\
	 != Vector2.ZERO:
		await get_tree().create_timer(0.075).timeout
		Global.player_prev_vel = Vector2.ZERO

func player_animation() -> void:
#	$"AnimatedSprite2D".flip_h = false
	if velocityRigid == Vector2.ZERO: 
		animated.play("stand")
		animated.flip_h = false
	elif velocityRigid.y > 0: 
		animated.play("walk_down")
		animated.flip_h = false
	elif velocityRigid.y < 0: 
		animated.play("walk_up")
		animated.flip_h = false
	elif velocityRigid.x < 0: 
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

func rand_teleport(constraint_2dvec : Vector2 = Vector2.ZERO) -> void:
	var temp_tele : Area2D = tele.duplicate()
	temp_tele.global_position = global_position
	temp_tele.constraint_2dvec = constraint_2dvec
	get_parent().add_child(temp_tele)

func _on_follower_cleanup_timer_timeout() -> void:
	if Global.follower_mod > 1:
		for i in range(Global.follower_array.size() - 1, 0, -1):
			for a in range(i - 1, -1, -1):
				if (Global.follower_array[i].global_position - 
				Global.follower_array[a].global_position).length() < 5:
					Global.follower_array[i].remove_follower()
					break
