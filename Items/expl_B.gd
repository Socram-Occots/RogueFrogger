extends Item

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	var metalist : PackedStringArray = body.get_meta_list()
	for i in ["Player", "Follower"]:
		if i in metalist:
			Global.inc_expl_B(Global.follower_mod)
			queue_free()
			break

func _ready() -> void:
	defaultMeta()
	gracePeriod()
