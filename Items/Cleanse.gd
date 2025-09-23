extends Area2D

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	var metalist : PackedStringArray = body.get_meta_list()
	for i in ["Player", "Follower"]:
		if i in metalist: 
			Global.cleanse_curse(1 * Global.follower_mod)
			queue_free()
			break

@warning_ignore("unused_parameter")
func _process(delta):
	if global_position.y - Global.player_pos_y > Global.despawn_lower:
		queue_free()
