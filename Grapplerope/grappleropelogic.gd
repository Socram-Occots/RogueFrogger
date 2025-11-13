extends Line2D

@onready var crosser_global_pos : Vector2 = Vector2(Global.player_pos_x, Global.player_pos_y)
@onready var seeking : bool = true
@onready var direction : int = 1
@onready var grapple_head: Area2D = $grappleHead
@onready var grapple_pos : Vector2 = grapple_head.global_position
@onready var glideandgrapplebonus : bool = false
@onready var velocity : Vector2 = Vector2(0, 0)
var crosser : RigidBody2D
var dir_vector : Vector2

func _ready() -> void:
	grapple_head.global_position = crosser_global_pos
	set_point_position(0, crosser_global_pos)
	set_point_position(1, crosser_global_pos)

func delete_rope(headalive : bool = true) -> void:
	Global.grapple_cool_down_bool = true
	crosser.grappling = false
	crosser.grappled = false
	if headalive && is_instance_valid(grapple_head):
		grapple_head.queue_free()
	queue_free()

func _physics_process(delta: float) -> void:
	
	if is_instance_valid(grapple_head):
		crosser_global_pos.x = Global.player_pos_x
		crosser_global_pos.y = Global.player_pos_y
			
		if seeking:
			if dir_vector == Vector2.ZERO:
				grapple_head.global_position.y += delta * -1 * Global.grapple_speed
			else:
				grapple_head.global_position += delta * dir_vector * Global.grapple_speed
		
		grapple_pos = grapple_head.global_position
		
		set_point_position(0, to_local(crosser_global_pos))
		set_point_position(1, to_local(grapple_pos))
		velocity = -1 * Vector2(crosser_global_pos.x - grapple_pos.x, 
		crosser_global_pos.y - grapple_pos.y).normalized() * Global.grapple_strength
		
		
		if !(seeking || crosser.gliding):
			crosser.apply_central_force(velocity * delta)
			crosser.velocityGrapple = velocity
		
		if crosser_global_pos.distance_to(grapple_pos) > Global.grapple_length:
			delete_rope()
	else:
		delete_rope(false)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("rope_cont") || event.is_action_pressed("rope"):
		delete_rope()
		
func end_seeking_and_attach(subject) -> void:
	if seeking:
		seeking = false
		crosser.grappled = true
		get_node("grappleHead").call_deferred("reparent", subject)
		
		if crosser.gliding:
			crosser.apply_central_force(velocity * get_process_delta_time())
			crosser.velocityGrapple = velocity
	elif subject.get_collision_layer() == 4:
		delete_rope()

func _on_grapple_head_area_entered(area: Area2D) -> void:
	end_seeking_and_attach(area)

func _on_grapple_head_body_entered(body: Node2D) -> void:
	end_seeking_and_attach(body)

func _on_timer_timeout() -> void:
	direction *= -1
	
