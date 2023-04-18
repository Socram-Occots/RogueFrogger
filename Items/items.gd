extends Node2D

func _process(delta):
	if global_position.y - Global.player_pos_y > 777:
		queue_free()
