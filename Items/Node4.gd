extends Area2D

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	var metalist : PackedStringArray = body.get_meta_list()
	if "Player" in metalist:
		if Global.expl_B_mod == 0:
			Global.expl_B_labelon = true
		Global.expl_B_mod += 1
		Global.expl_B_impulse_mod += 0.01
		Global.expl_B_size_mod += 0.01
		Global.updatelabels = true
		queue_free()

@warning_ignore("unused_parameter")
func _process(delta):
	if global_position.y - Global.player_pos_y > 888:
		queue_free()
