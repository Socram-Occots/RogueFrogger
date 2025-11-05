extends RigidBody2D

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
@onready var vLength : float = 0
@onready var velocityGrapple : Vector2 = Vector2(0.0, 0.0)
@onready var grappled : bool = false

@onready var grapplehook : Line2D = Globalpreload.grapplehook.duplicate()
@onready var tele : Area2D = Globalpreload.tele.duplicate()

func _ready() -> void:
	Globalpreload.delete_array.append_array([grapplehook,tele])
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
	var walking : bool = false
	velocityRigid = Input.get_vector(
		"left_cont_stick", "right_cont_stick", "up_cont_stick", "down_cont_stick"
		)
		
	if velocityRigid.is_equal_approx(Vector2.ZERO):
		if Input.is_action_pressed("left_cont_button"):
			velocityRigid.x -= 1
		if Input.is_action_pressed("right_cont_button"):
			velocityRigid.x += 1
		if Input.is_action_pressed("down_cont_button"):
			velocityRigid.y += 1
		if Input.is_action_pressed("up_cont_button"):
			velocityRigid.y -= 1
			
	if velocityRigid.is_equal_approx(Vector2.ZERO):
		if Input.is_action_pressed("left_a"):
			velocityRigid.x -= 1
		if Input.is_action_pressed("right_d"):
			velocityRigid.x += 1
		if Input.is_action_pressed("down_s"):
			velocityRigid.y += 1
		if Input.is_action_pressed("up_w"):
			velocityRigid.y -= 1
		walking = Input.is_action_pressed("walk")
	else:
		walking = Input.is_action_pressed("walk_cont")
	
	var playerspeed_penalty : float = (1 - (Global.playerslow_percent *\
	(Global.playerslow_mod_real - 1)))

	velocityRigid = velocityRigid.normalized() *\
	Global.player_speed_scaling * playerspeed_penalty
	
	if walking:
		velocityRigid /= 2
		vLength = (Global.player_speed_scaling * playerspeed_penalty) / 2
	else:
		vLength = Global.player_speed_scaling * playerspeed_penalty

func dash_decision_tree() -> void:
	var dash_input_pressed : bool = Input.is_action_just_pressed("dash_cont") || \
	Input.is_action_just_pressed("dash")
	if dash_input_pressed && Global.dash &&\
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
	var grapple_input_pressed : bool = Input.is_action_just_pressed("rope_cont") || \
	Input.is_action_just_pressed("rope")
	if grapple_input_pressed && Global.grapple &&\
	 !Global.grapple_cool_down_bool && !grappling:
		grappling = true
		var grappledupe : Line2D = grapplehook.duplicate()
		if Global.using_cont && SettingsDataContainer.get_controller_aim_toggle():
			var contr_dir : Vector2 = Vector2.ZERO
			contr_dir.y += -1 * Input.get_action_raw_strength("up_cont_aim")
			contr_dir.y += Input.get_action_raw_strength("down_cont_aim")
			contr_dir.x += Input.get_action_raw_strength("right_cont_aim")
			contr_dir.x += -1 * Input.get_action_raw_strength("left_cont_aim")
			grappledupe.dir_vector = contr_dir.normalized()
		elif !Global.using_cont && SettingsDataContainer.get_mouse_aim_toggle():
			grappledupe.dir_vector = (get_global_mouse_position() - global_position).normalized()
		else:
			grappledupe.dir_vector = velocityRigid.normalized()
		grappledupe.global_position = global_position
		grappledupe.crosser = $"."
		get_parent().add_child(grappledupe)

func glide_decision_tree() -> void:
	var glide_input_pressed : bool = Input.is_action_just_pressed("glide_cont") || \
	Input.is_action_just_pressed("glide")
	if glide_input_pressed && Global.glide:
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

func _physics_process(delta: float) -> void:
	#print(global_position)
	Global.player_pos_x = global_position.x
	Global.player_pos_y = global_position.y
	
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
	else:
		if abs(velocityRigid.y) > abs(velocityRigid.x):
			if velocityRigid.y > 0: 
				animated.play("walk_down")
				animated.flip_h = false
			else:
				animated.play("walk_up")
				animated.flip_h = false
		else:
			if velocityRigid.x < 0:
				animated.play("walk_side")
				animated.flip_h = false
			else:
				animated.play("walk_side")
				animated.flip_h = true
		
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
