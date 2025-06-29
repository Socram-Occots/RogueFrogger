extends RigidBody2D

@onready var velocityRigid : Vector2 = Vector2(0.0, 0.0)
@onready var velocityGrapple : Vector2 = Vector2(0.0, 0.0)
@onready var prev_follower_index : int
@onready var prev_follower_id : int
@onready var glide_boots: ColorRect = $GlideBoots
@onready var animated : AnimatedSprite2D = $playermove
@onready var gliding : bool = false
@onready var dashing : bool = false
@onready var dash_check : bool = true
@onready var grappled : bool = false
@onready var grapple_check : bool = true

func find_prev_follower() -> void:
	var self_index : int = Global.follower_array.find(self, 1)
	for i in range(self_index - 1, -1, -1):
		if is_instance_valid(Global.follower_array[i]):
			prev_follower_index = i
			prev_follower_id = Global.follower_array[i].get_meta("Follower")
			break
		else:
			Global.follower_array.remove_at(i)
			i -= 1
			
	#print(prev_follower_index)

func _ready() -> void:
	find_prev_follower()
	velocity_Logic()
	apply_central_force(velocityRigid * get_process_delta_time())

func _process(delta: float) -> void:
	if !gliding:
		sleeping = true
		apply_central_force(velocityRigid * delta)
		if grappled:
			apply_central_force(velocityGrapple * delta)
	

func velocity_Logic() -> void:
	var temp_rigid : RigidBody2D = Global.follower_array[prev_follower_index]
	#print(is_instance_valid(temp_rigid), temp_rigid.get_meta("Follower"))
	if !(is_instance_valid(temp_rigid) || temp_rigid.get_meta("Follower") == prev_follower_id):
		find_prev_follower()
		temp_rigid = Global.follower_array[prev_follower_index]
	
	velocityRigid = temp_rigid.velocityRigid
	velocityGrapple = temp_rigid.velocityGrapple
	
	glide_boots.visible = temp_rigid.gliding
	
	if temp_rigid.grappled:
		grappled = true
	else:
		grapple_check = true
		grappled = false
	
	if temp_rigid.gliding:
		gliding = true
		animated.pause()
		
		if temp_rigid.dashing && dash_check:
			dash_check = false
			dashing = true
			apply_central_force(velocityRigid * get_process_delta_time())
			await get_tree().create_timer(Global.dash_time).timeout
			dash_check = true
			dashing = false
			
		if grappled && grapple_check:
			grapple_check = false
			apply_central_force(velocityRigid * get_process_delta_time())
		
	else:
		gliding = false
		player_animation()

func _on_timer_timeout() -> void:
	velocity_Logic()

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

func remove_follower() -> void:
	var self_index : int = Global.follower_array.find(self, 1)
	Global.follower_array.remove_at(self_index)
	Global.follower_mod -= 1
	if Global.follower_mod == 1:
		Global.followerlabelon = true
		Global.updatelabels = true
