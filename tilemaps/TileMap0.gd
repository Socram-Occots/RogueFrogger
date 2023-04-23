extends TileMap

var not_entered = true

@warning_ignore("unused_parameter")
func _on_area_0_body_entered(body):
	if not_entered:
		Global.spawnTerrain = true
		not_entered = false
		Global.score += 1
#		print(Global.player_pos_x)
#		print(Global.player_pos_y)
