extends Area2D

@onready var canidates : Array[bool] = []
@onready var short_teleport : bool = false
@export var num_of_col : int = 0
@export var constraint_2dvec : Vector2 = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	canidates.resize(num_of_col)
	canidates.fill(true)
	
	if constraint_2dvec != Vector2.ZERO:
		short_teleport = true
	
	# we need two of these because the engine waits a tick to
	# look for its collisons after placing an entity
	await get_tree().physics_frame
	await get_tree().physics_frame

	var qualified : Array[Vector2] = []
	var temp_rigid : RigidBody2D = Global.follower_array[0]
	var temp_rigid_global : Vector2 = temp_rigid.global_position
	var temp_line_global_y : float = Global.game_line.global_position.y
	var temp_pw : int = Global.player_width_px
	for i in range(0, len(canidates)) :
		if canidates[i]:
			var temp : CollisionShape2D = get_node("CollisionShape2D" + str(i))
			var temp_global : Vector2 = temp.global_position
			if temp_global.x > temp_pw \
			and temp_global.x < 1920 - temp_pw and \
			temp_global.y < temp_line_global_y - temp_pw:
				if short_teleport:
					if temp_global.x > (temp_rigid_global.x - constraint_2dvec.x) \
					and temp_global.x < (temp_rigid_global.x + constraint_2dvec.x) \
					and temp_global.y > (temp_rigid_global.y - constraint_2dvec.y) \
					and temp_global.y < (temp_rigid_global.y + constraint_2dvec.y):
						qualified.append(temp_global)
				else:
					qualified.append(temp_global)
	
	if !qualified.is_empty():
		var winner_vect2 : Vector2 = qualified.pick_random()
		
		var item_dict : Dictionary = {}
		
		if Global.player_speed_mod > 0:
			item_dict["PlayerSpeed"] = Global.player_speed_mod
		if Global.glide_mod > 0:
			item_dict["GlideBoots"] = Global.glide_mod
		if Global.dash_mod > 0:
			item_dict["Dash"] = Global.dash_mod
		if Global.expl_B_mod > 0:
			item_dict["expl_B"] = Global.expl_B_mod
		if Global.grapple_mod > 0:
			item_dict["Grapple"] = Global.grapple_mod
		if Global.follower_mod > Global.follower_mod_base:
			item_dict["Follower"] = Global.follower_mod
		if Global.shrink_mod > 0:
			item_dict["Shrink"] = Global.shrink_mod
		if Global.hole_mod > 0:
			item_dict["Hole"] = Global.hole_mod
			
		if !item_dict.is_empty():
			var items_size : int = item_dict.keys().size()
			var chosen : String = item_dict.keys()[
				GRand.itemrand.randi() % items_size]
			
			if chosen == "PlayerSpeed":
				Global.inc_PlayerSpeed(-1)
			if chosen == "GlideBoots":
				Global.inc_GlideBoots(-1)
			if chosen == "Dash":
				Global.inc_Dash(-1)
			if chosen == "expl_B":
				Global.inc_expl_B(-1)
			if chosen == "Grapple":
				Global.inc_GrappleRope(-1)
			if chosen == "Follower":
				Global.inc_Follower(-1)
			if chosen == "Shrink":
				Global.inc_Shrink(-1)
			if chosen == "Hole":
				Global.inc_Hole(-1)
			
			teleItems(chosen, winner_vect2)
			
			var templine : Line2D = Globalpreload.teleportline.duplicate()
			templine.default_color = Color(1, 1, 1)
			templine.set_point_position(0, temp_rigid.global_position)
			templine.set_point_position(1, winner_vect2)
			get_tree().root.get_node("Level/teleportlines").add_child(templine)

	queue_free()

func teleItems(item_str: String, pos : Vector2) -> void:
	var item : Area2D = Globalpreload.items_instantiate.get_node(item_str).duplicate()
	item.visible = true
	item.position = pos
	item.set_meta("Item", null)
	get_tree().root.get_node("Level/Ysort").add_child(item)

@warning_ignore("unused_parameter")
func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	canidates[local_shape_index] = false

@warning_ignore("unused_parameter")
func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	canidates[local_shape_index] = false
