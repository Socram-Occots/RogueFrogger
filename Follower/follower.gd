extends RigidBody2D

@onready var velocityRigid : Vector2 = Vector2(0.0, 0.0)

func _physics_process(delta: float) -> void:
	sleeping = true
	apply_central_force(velocityRigid * delta)


func _on_timer_timeout() -> void:
	velocityRigid = Global.follower_vel
