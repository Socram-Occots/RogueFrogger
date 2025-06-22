extends RigidBody2D

@onready var velocityRigid : Vector2 = Vector2(0.0, 0.0)
@onready var prev_follower_index : int
@onready var prev_follower_id : int
@onready var glide_boots: ColorRect = $GlideBoots
@onready var animated : AnimatedSprite2D = $playermove
@onready var gliding : bool = false
@onready var dashandglidebonus : bool = false
@onready var dash_check : bool = true
@onready var dashing : bool = false

func find_prev_follower() -> void:
	var self_index : int = Global.follower_array.find(self, 1)
	print(self_index)
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

func _process(delta: float) -> void:
	if !gliding:
		sleeping = true
		apply_central_force(velocityRigid * delta)
	elif dashandglidebonus:
		dashandglidebonus = false
		apply_central_force(velocityRigid * delta)

func _on_timer_timeout() -> void:
	var temp_rigid : RigidBody2D = Global.follower_array[prev_follower_index]
	#print(is_instance_valid(temp_rigid), temp_rigid.get_meta("Follower"))
	if is_instance_valid(temp_rigid) && temp_rigid.get_meta("Follower") == prev_follower_id:
		velocityRigid = temp_rigid.velocityRigid
	else:
		find_prev_follower()
		temp_rigid = Global.follower_array[prev_follower_index]
		velocityRigid = temp_rigid.velocityRigid
	
	glide_boots.visible = temp_rigid.get_node("GlideBoots").visible
	
	if !glide_boots.visible:
		gliding = false
		player_animation()
	else:
		gliding = true
		animated.pause()
	
	if temp_rigid.dashing && dash_check:
		dashing = true
		dash_check = false
		dashandglidebonus = true
		await get_tree().create_timer(Global.dash_time).timeout
		dash_check = true
		dashing = false

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
