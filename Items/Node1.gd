extends Area2D

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	var metalist : PackedStringArray = body.get_meta_list()
	if "Player" in metalist:
		if Global.glide_mod == 0:
			Global.glidelabelon = true
		Global.glide_mod += 1
		Global.glide_cool_down /= 1.005
		Global.glide_time += 0.025
		Global.updatelabels = true
		queue_free()

@warning_ignore("unused_parameter")
func _process(delta):
	if global_position.y - Global.player_pos_y > 888:
		queue_free()
