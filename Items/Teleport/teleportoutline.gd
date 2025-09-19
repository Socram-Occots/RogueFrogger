extends Area2D

@onready var canidates : Array[bool] = []
@onready var short_teleport : bool = false
@export var num_of_col : int = 0
@export var constraint_2dvec : Vector2 = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	canidates.resize(num_of_col)
	canidates.fill(true)
	
	if constraint_2dvec != Vector2.ZERO:
		short_teleport = true
	
	await get_tree().process_frame
	
	var qualified : Array[Vector2] = []
	var temp_rigid : RigidBody2D = Global.follower_array[0]
	var temp_rigid_global : Vector2 = temp_rigid.global_position
	var temp_line_global_y : float = Global.game_line.global_position.y
	var temp_pw : int = Global.player_width_px
	for i in range(0, len(canidates)) :
		if canidates[i]:
			var temp : CollisionShape2D = get_node("CollisionShape2D" + str(i))
			var temp_global : Vector2 = temp.global_position
			if temp_global.x > temp_pw \
			and temp_global.x < 1920 - temp_pw and \
			temp_global.y < temp_line_global_y - temp_pw:
				if short_teleport:
					if temp_global.x > (temp_rigid_global.x - constraint_2dvec.x) \
					and temp_global.x < (temp_rigid_global.x + constraint_2dvec.x) \
					and temp_global.y > (temp_rigid_global.y - constraint_2dvec.y) \
					and temp_global.y < (temp_rigid_global.y + constraint_2dvec.y):
						qualified.append(temp_global)
				else:
					qualified.append(temp_global)
	
	if !qualified.is_empty():
		
		var winner_vect2 : Vector2 = qualified.pick_random()
		
		PhysicsServer2D.body_set_state(
			temp_rigid.get_rid(),
			PhysicsServer2D.BODY_STATE_TRANSFORM,
			Transform2D.IDENTITY.translated(winner_vect2)
			)
	
		if Global.follower_mod > 1:
			Global.wipe_null_followers()
			var distance : Vector2 = winner_vect2 - temp_rigid_global
			for i in range(1, Global.follower_array.size()):
				var new_dist : Vector2 = Global.follower_array[i].global_position + distance
				
				if new_dist.x < temp_pw:
					new_dist.x = temp_pw
				elif new_dist.x > 1920 - temp_pw:
					new_dist.x = 1920 - temp_pw
				if new_dist.y > temp_line_global_y - temp_pw:
					new_dist.y = temp_line_global_y - temp_pw
					
				PhysicsServer2D.body_set_state(
					Global.follower_array[i].get_rid(),
					PhysicsServer2D.BODY_STATE_TRANSFORM,
					Transform2D.IDENTITY.translated(new_dist)
			)
	
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass

@warning_ignore("unused_parameter")
func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	canidates[local_shape_index] = false

@warning_ignore("unused_parameter")
func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	canidates[local_shape_index] = false
