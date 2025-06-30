# level.gd
extends "res://Level/level_gen.gd"

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	update_labels()
	dash_check()
	terrain_check()
	gamba_check()
	follower_check()

func _ready() -> void:
	#load pause and game over menu
	loadDefeat()
	loadPause()
	# load gamba picker
	load_gamba_picker()
	#player
	var player : RigidBody2D = CROSSER.instantiate()
	Global.follower_array.append(player)
	player.position.x = $PlayerStart.global_position.x
	player.position.y = $PlayerStart.global_position.y
	Global.player_pos_x = player.position.x
	Global.player_pos_y = player.position.y
	$PlayerStart.queue_free()
	player.visible = true
	$Ysort.add_child(player)
	# level
	spawnBorder(960, Global.player_pos_y)
	firstTerrainSpawn(0, $spawnterrain.global_position.y)
	for i in 18:
		terrainSpawnLogic()
	$CanvasLayer/Score.text = "Score " + str(Global.score)
	# lineofdeath
	spawnLineOfDeath()
	#labels
	# high score line
	spawn_high_score_line()
	
