extends RigidBody2D

@onready var velocityRigid : Vector2 = Vector2(0.0, 0.0)
@onready var prev_follower_index : int
@onready var prev_follower_id : int
@onready var glide_boots: ColorRect = $GlideBoots
@onready var animated : AnimatedSprite2D = $playermove

func find_prev_follower() -> void:
	var self_index : int = Global.follower_array.find(self, 1)
	for i in range(self_index - 1, -1, -1):
		var index_adjusted = self_index - i
		if is_instance_valid(Global.follower_array[index_adjusted]):
			prev_follower_index = index_adjusted
			prev_follower_id = Global.follower_array[index_adjusted].get_meta("Follower")
			break
		else:
			Global.follower_array.remove_at(index_adjusted)
			i -= 1

func _ready() -> void:
	find_prev_follower()

func _process(delta: float) -> void:
	sleeping = true
	apply_central_force(velocityRigid * delta)

func _on_timer_timeout() -> void:
	var temp_rigid : RigidBody2D = Global.follower_array[prev_follower_index]
	if is_instance_valid(temp_rigid) && temp_rigid.get_meta("Follower") == prev_follower_id:
		velocityRigid = temp_rigid.velocityRigid
	else:
		find_prev_follower()
		temp_rigid = Global.follower_array[prev_follower_index]
		velocityRigid = temp_rigid.velocityRigi
	
	glide_boots.visible = temp_rigid.get_node("GlideBoots").visible
	
	if !glide_boots.visible:
		player_animation()
	else:
		animated.pause()
	

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
