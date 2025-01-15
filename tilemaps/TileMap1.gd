extends TileMap

@onready var not_entered : bool = true

@warning_ignore("unused_parameter")
func _on_area_1_body_entered(body):
	if not_entered:
		not_entered = false
		Global.score += 1
		Global.spawnTerrain = true
#		print(Global.player_pos_x)
#		print(Global.player_pos_y)
