extends Area2D

@onready var collision_dict = {}
@export var num_of_col = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(num_of_col):
		collision_dict[i] = null
	await get_tree().process_frame
	var teleport_pos : Vector2 = get_node("CollisionShape2D" + str(collision_dict.keys().pick_random())).global_position
	PhysicsServer2D.body_set_state(
		Global.follower_array[0].get_rid(),
		PhysicsServer2D.BODY_STATE_TRANSFORM,
		Transform2D.IDENTITY.translated(teleport_pos)
		)
# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass

@warning_ignore("unused_parameter")
func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if collision_dict.has(local_shape_index):
		collision_dict.erase(local_shape_index)

@warning_ignore("unused_parameter")
func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if collision_dict.has(local_shape_index):
		collision_dict.erase(local_shape_index)
