extends Line2D

@onready var crosser_global_pos : Vector2 = Vector2(Global.player_pos_x, Global.player_pos_y)
@onready var seeking = true
@onready var direction = 1
@onready var grapple_head: Area2D = $grappleHead
var crosser : RigidBody2D
var dir_vector : Vector2

func _ready() -> void:
	grapple_head.global_position = crosser_global_pos
	set_point_position(0, crosser_global_pos)
	set_point_position(1, crosser_global_pos)

func delete_rope() -> void:
	grapple_head.queue_free()
	queue_free()

func _process(delta: float) -> void:
	crosser_global_pos.x = Global.player_pos_x
	crosser_global_pos.y = Global.player_pos_y
	#print(crosser_global_pos, grapple_head.global_position)
	
	if seeking:
		if dir_vector == Vector2.ZERO:
			grapple_head.global_position.y += delta * -1 * 100
		else:
			grapple_head.global_position += dir_vector * 100 * delta
	
	set_point_position(0, to_local(crosser_global_pos))
	set_point_position(1, to_local(grapple_head.global_position))
	var areapos : Vector2 = grapple_head.global_position
	var velocity = -1 * Vector2(crosser_global_pos.x - areapos.x, 
	crosser_global_pos.y - areapos.y).normalized() * 100
	
	if !seeking:
		crosser.apply_central_force(velocity)
	
	if crosser_global_pos.distance_to(areapos) > 500:
		delete_rope()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("rope"):
		delete_rope()
		
func end_seeking_and_attach(subject) -> void:
	if seeking:
		seeking = false
		get_node("grappleHead").call_deferred("reparent", subject)

func _on_grapple_head_area_entered(area: Area2D) -> void:
	end_seeking_and_attach(area)

func _on_grapple_head_body_entered(body: Node2D) -> void:
	end_seeking_and_attach(body)

func _on_timer_timeout() -> void:
	direction *= -1
	
