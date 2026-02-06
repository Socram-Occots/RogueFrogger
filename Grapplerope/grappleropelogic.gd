extends Line2D

@onready var crosser_global_pos : Vector2 = Vector2(Global.player_pos_x, Global.player_pos_y)
@onready var seeking : bool = true
@onready var direction : int = 1
@onready var grapple_head: Area2D = $grappleHead
@onready var grapple_pos : Vector2 = grapple_head.global_position
@onready var glideandgrapplebonus : bool = false
@onready var velocity : Vector2 = Vector2(0, 0)
@onready var grappleassistanceTiers : Array[bool]
@onready var reveal_hitboxes : bool = SettingsDataContainer.get_show_hitboxes()
@onready var main_hitbox: Ellipse = $grappleHead/Ellipse

@onready var grappleassist: Area2D = $grappleHead/grappleassist
@onready var grappleassistArr : Array[Node] = grappleassist.get_children()

var crosser : RigidBody2D
var dir_vector : Vector2

func _ready() -> void:
	grapple_head.set_meta("Grapplehead", false)
	grapple_head.global_position = crosser_global_pos
	main_hitbox.visible = reveal_hitboxes
	set_point_position(0, crosser_global_pos)
	set_point_position(1, crosser_global_pos)
	grappleassistanceTiers.resize(3)
	grappleassistanceTiers.fill(true)
	for i in grappleassistArr:
		i.visible = false

func delete_rope(headalive : bool = true) -> void:
	seeking = false
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
		
		grappleassistcheck()
		
		set_point_position(0, to_local(crosser_global_pos))
		set_point_position(1, to_local(grapple_pos))
		velocity = -1 * Vector2(crosser_global_pos.x - grapple_pos.x, 
		crosser_global_pos.y - grapple_pos.y).normalized() * Global.grapple_strength
		
		var dist_to_crosser : float = crosser_global_pos.distance_to(grapple_pos)
		
		if !(seeking || crosser.gliding) && dist_to_crosser > 100:
			crosser.apply_central_force(velocity * delta)
			crosser.velocityGrapple = velocity
		
		if dist_to_crosser > Global.grapple_length:
			delete_rope()
	else:
		delete_rope(false)

func grappleassistcheck() -> void:
	if grappleassistanceTiers[0] && crosser_global_pos.distance_to(grapple_pos) > Global.grapple_length_base / 2:
		for i in range(0, 8):
			grappleassistArr[i].set_deferred("disabled", false)
			grappleassistArr[i].visible = reveal_hitboxes
		grappleassistanceTiers[0] = false
	elif grappleassistanceTiers[1] && crosser_global_pos.distance_to(grapple_pos) > Global.grapple_length_base:
		for i in range(8, 24):
			grappleassistArr[i].set_deferred("disabled", false)
			grappleassistArr[i].visible = reveal_hitboxes
		grappleassistanceTiers[1] = false
	elif grappleassistanceTiers[2] && crosser_global_pos.distance_to(grapple_pos) > Global.grapple_length_base * 1.5:
		for i in range(24, 48):
			grappleassistArr[i].set_deferred("disabled", false)
			grappleassistArr[i].visible = reveal_hitboxes
		grappleassistanceTiers[2] = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("rope_cont") || event.is_action_pressed("rope"):
		delete_rope()
		
func end_seeking_and_attach(subject) -> void:
	if seeking:
		
		seeking = false
		grappleassist.queue_free()
		crosser.grappled = true
		get_node("grappleHead").call_deferred("reparent", subject)
		
		if crosser.gliding:
			crosser.apply_central_force(velocity * get_process_delta_time())
			crosser.velocityGrapple = velocity
		
		# prevent head from glitching
		grapple_head.visible = false
		await Global.secure_await_phy_frame(2)
		if is_instance_valid(grapple_head):
			grapple_head.visible = true
		
	elif subject.get_collision_layer() == 4:
		delete_rope()

func _on_grapple_head_area_entered(area: Area2D) -> void:
	end_seeking_and_attach(area)

func _on_grapple_head_body_entered(body: Node2D) -> void:
	end_seeking_and_attach(body)

func _on_timer_timeout() -> void:
	direction *= -1

@warning_ignore("unused_parameter")
func _on_grappleassist_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if seeking:
		grapple_head.global_position = grappleassist.get_node("CollisionShape2D" + str(local_shape_index)).global_position
		end_seeking_and_attach(area)

@warning_ignore("unused_parameter")
func _on_grappleassist_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if seeking:
		grapple_head.global_position = grappleassist.get_node("CollisionShape2D" + str(local_shape_index)).global_position
		end_seeking_and_attach(body)
