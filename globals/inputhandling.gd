extends Node

func crosser_move_input(velocityRigid : Vector2) -> Vector2:
	# controller is prioritized
	velocityRigid = Input.get_vector(
		"move_left", "move_right", "move_forward", "move_back"
		)
		
	if !velocityRigid.is_equal_approx(Vector2.ZERO):
		return velocityRigid

	if Input.is_action_pressed("left_a"):
		velocityRigid.x -= 1
	if Input.is_action_pressed("right_d"):
		velocityRigid.x += 1
	if Input.is_action_pressed("down_s"):
		velocityRigid.y += 1
	if Input.is_action_pressed("up_w"):
		velocityRigid.y -= 1
		
	return velocityRigid

func dash_input(event : InputEvent) -> bool:
	return true

func grapple_input(event : InputEvent) -> bool:
	return true

func grapple_aiming_input(event : InputEvent) -> Vector2:
	return Vector2.ZERO
