extends Line2D

@onready var crosser_global_pos : Vector2 = Vector2(Global.player_pos_x, Global.player_pos_y)
@onready var seeking : bool = true
@onready var direction : int = 1
@onready var grapple_head: Area2D = $grappleHead
@onready var velocity : Vector2 = Vector2(0, 0)
@onready var collision_shape_2d: CollisionShape2D = $grappleHead/CollisionShape2D
@onready var grappleassist: Area2D = $grappleHead/grappleassist
var item : Area2D

func _ready() -> void:
	grappleassist.visible = false
	grapple_head.global_position = crosser_global_pos
	set_point_position(0, crosser_global_pos)
	set_point_position(1, crosser_global_pos)
	await get_tree().create_timer(10).timeout
	if is_instance_valid($"."):
		delete_rope(true)
	if is_instance_valid(item):
		item.global_position.x = Global.player_pos_x
		item.global_position.y = Global.player_pos_y

func delete_rope(headalive : bool = true) -> void:
	if headalive && is_instance_valid(grapple_head):
		grapple_head.queue_free()
	queue_free()

func _physics_process(delta: float) -> void:
	if is_instance_valid(grapple_head) && is_instance_valid(item):
		crosser_global_pos.x = Global.player_pos_x
		crosser_global_pos.y = Global.player_pos_y
		
		var dirvector : Vector2
		
		if seeking:
			dirvector = (item.global_position - crosser_global_pos).normalized()
			grapple_head.global_position += dirvector * delta * Global.grapple_speed * 2
		else:
			dirvector = (crosser_global_pos - item.global_position).normalized()
			item.global_position += dirvector * delta * Global.grapple_speed
			grapple_head.global_position = item.global_position
		
		if seeking && (crosser_global_pos - grapple_head.global_position).length() > \
		(crosser_global_pos - item.global_position).length():
			seeking = false
			grapple_head.global_position = item.global_position
			get_node("grappleHead").call_deferred("reparent", item)
			item.set_collision_mask_value(7, false)
			item.set_collision_mask_value(8, false)
			item.set_collision_mask_value(9, false)
			item.set_collision_mask_value(10, false)
			
		
		set_point_position(0, to_local(crosser_global_pos))
		set_point_position(1, to_local(grapple_head.global_position))
	else:
		delete_rope(false)
