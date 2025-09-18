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

	for i in range(0, len(canidates)) :
		if canidates[i]:
			var temp : CollisionShape2D = get_node("CollisionShape2D" + str(i))
			var temp_global : Vector2 = temp.global_position
			var temp_pw : int = Global.player_width_px
			if temp_global.x > temp_pw \
			and temp_global.x < (1920 - temp_pw) and \
			temp_global.y < (temp_line_global_y - temp_pw):
				if short_teleport:
					if temp_global.x > (temp_rigid_global.x - constraint_2dvec.x) \
					and temp_global.x < (temp_rigid_global.x + constraint_2dvec.x) \
					and temp_global.y > (temp_rigid_global.y - constraint_2dvec.y) \
					and temp_global.y < (temp_rigid_global.y + constraint_2dvec.y):
						qualified.append(temp_global)
				else:
					qualified.append(temp_global)
	
	if !qualified.is_empty():
		PhysicsServer2D.body_set_state(
			temp_rigid.get_rid(),
			PhysicsServer2D.BODY_STATE_TRANSFORM,
			Transform2D.IDENTITY.translated(qualified.pick_random())
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
