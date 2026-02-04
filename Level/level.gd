# level.gd
extends "res://Level/level_gen.gd"

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	update_labels()
	terrain_check()
	gamba_check()
	follower_check()
	dvd_bounce_check()

func _ready() -> void:
	Globalpreload.delete_array = arr_to_del
	# load default/sandbox stats
	load_element_stats()
	#load pause and game over menu
	loadDefeat()
	loadPause()
	# load gamba picker
	load_gamba_picker()
	#player
	var player : RigidBody2D = Globalpreload.CROSSER.instantiate()
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
	terrainSpawnLogic(18)
	$CanvasLayer/Score.text = "Score " + str(Global.score)
	# lineofdeath
	spawnLineOfDeath()
	#labels
	# high score line
	spawn_high_score_line()
	#dvdbounce
	spawn_dvd_bounce_area()
	# spawn starter items
	await get_tree().physics_frame
	load_starter_items()
