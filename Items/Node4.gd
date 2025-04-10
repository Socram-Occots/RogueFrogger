extends Area2D

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	var metalist : PackedStringArray = body.get_meta_list()
	if "Player" in metalist:
		if Global.grapple_mod == 0:
			Global.grapple = true
			Global.grapplelabelon = true
		Global.grapple_mod += 1
		Global.grapple_speed += 5
		Global.grapple_strength += 25
		Global.grapple_length += 5
		Global.grapple_cool_down /= 1.005
		Global.updatelabels = true
		queue_free()

@warning_ignore("unused_parameter")
func _process(delta):
	if global_position.y - Global.player_pos_y > 888:
		queue_free()
