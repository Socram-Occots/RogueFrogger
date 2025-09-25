extends RigidBody2D

var velocity : Vector2 = Vector2(250, 250)

func _physics_process(delta: float) -> void:
	var collision_info : KinematicCollision2D = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal()
		).rotated(deg_to_rad(randf_range(0,1)))
