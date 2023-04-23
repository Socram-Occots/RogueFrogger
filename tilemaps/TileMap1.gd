extends TileMap

var not_entered = true

@warning_ignore("unused_parameter")
func _on_area_1_body_entered(body):
	if not_entered:
		Global.spawnTerrain = true
		not_entered = false
		Global.score += 1
