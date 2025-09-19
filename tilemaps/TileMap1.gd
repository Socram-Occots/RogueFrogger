extends TileMap

@onready var not_entered : bool = true

@warning_ignore("unused_parameter")
func _on_area_1_body_entered(body):
	var metalist : PackedStringArray = body.get_meta_list()
	if not_entered and "Player" in metalist:
		not_entered = false
		if Global.score < self.get_meta("TILE_ID"):
			Global.race_condition_tiles.append(self.get_meta("TILE_ID"))
			Global.spawnTerrain = true
	#		print(Global.player_pos_x)
	#		print(Global.player_pos_y)
