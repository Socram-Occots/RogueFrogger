extends Line2D

@onready var rigid_body_2d_stop: StaticBody2D = $"../RigidBody2DStop"
@onready var crosser: RigidBody2D = $"../crosser"
@onready var crosser_global_pos : Vector2 = Vector2(Global.player_pos_x, Global.player_pos_y)
@onready var area_body: Area2D = $AreaBody
@onready var seeking = true
@onready var direction = 1

func _ready() -> void:
	area_body.global_position = crosser_global_pos
	set_point_position(0, crosser_global_pos)
	set_point_position(1, crosser_global_pos)

func delete_rope() -> void:
	area_body.queue_free()
	queue_free()

func _process(delta: float) -> void:
	crosser_global_pos.x = Global.player_pos_x
	crosser_global_pos.y = Global.player_pos_y
	
	if seeking:
		var postion_displacement = 250 * delta
		area_body.global_position.x += postion_displacement
		
	set_point_position(0, crosser_global_pos)
	set_point_position(1, area_body.global_position)
	var areapos : Vector2 = area_body.global_position
	var velocity = -1 * Vector2(crosser_global_pos.x - areapos.x, 
	crosser_global_pos.y - areapos.y).normalized() * 100
	
	if !seeking:
		crosser.apply_central_force(velocity)
		rigid_body_2d_stop.global_position.y += direction * delta * 200
	
	if crosser_global_pos.distance_to(areapos) > 500:
		delete_rope()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("rope"):
		delete_rope()
		
func end_seeking_and_attach(subject) -> void:
	if seeking:
		seeking = false
		get_node("AreaBody").call_deferred("reparent", subject)

func _on_area_body_area_entered(area: Area2D) -> void:
	end_seeking_and_attach(area)

func _on_area_body_body_entered(body: Node2D) -> void:
	end_seeking_and_attach(body)

func _on_timer_timeout() -> void:
	direction *= -1
