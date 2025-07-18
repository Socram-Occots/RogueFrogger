extends Area2D

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	var metalist : PackedStringArray = body.get_meta_list()
	for i in ["Player", "Follower"]:
		if i in metalist:
			if Global.gamba_running:
				Global.gamba_mod += 1
			elif !(Global.gamba_update || Global.gamba_done):
				Global.gamba_update = true
			queue_free()
			break

@warning_ignore("unused_parameter")
func _process(delta):
	if global_position.y - Global.player_pos_y > Global.despawn_lower:
		queue_free()
