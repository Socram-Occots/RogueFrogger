extends Area2D

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	var metalist : PackedStringArray = body.get_meta_list()
	for i in ["Player", "Follower"]:
		if i in metalist:
			Global.inc_PlayerSpeed(1 * Global.follower_mod)
			queue_free()
			break
	
@warning_ignore("unused_parameter")
func _process(delta):
	pass
