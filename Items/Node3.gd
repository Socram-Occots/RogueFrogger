extends Area2D

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	var metalist : PackedStringArray = body.get_meta_list()
	if "Player" in metalist:
		if !Global.dash:
			Global.dashlabelon = true
		Global.dash = true
		Global.dash_mod += 1
		Global.dash_scaling += 0.02
		var adjustment = Global.dash_scaling/Global.dash_base
		Global.dash_time = Global.dash_base_time/adjustment
		Global.dash_cool_down /= 1.005
		Global.updatelabels = true
		queue_free()

@warning_ignore("unused_parameter")
func _process(delta):
	if global_position.y - Global.player_pos_y > 888:
		queue_free()
