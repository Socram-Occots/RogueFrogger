extends RigidBody2D

#@onready var not_moving = true
@onready var exploding : bool = false
@onready var animationExplo : AnimatedSprite2D = $AnimatedSprite2D
@onready var explosionCol : CollisionShape2D = $explosionbarrelexplosion/CollisionShape2D
@onready var explodingbarrelbody: RigidBody2D = $"."
@onready var impulse_collision_shape_2d: CollisionShape2D = $impulse/CollisionShape2D
@onready var expl_collision_shape_2d: CollisionShape2D = $explosionbarrelexplosion/CollisionShape2D
@onready var feet_collision_shape_2d: CollisionShape2D = $feet/CollisionShape2D
@onready var rectangle: Rectangle = $impulse/Rectangle
@onready var feetrectangle: Rectangle = $feet/CollisionShape2D/Rectangle
@onready var explrectangle: Rectangle = $explosionbarrelexplosion/CollisionShape2D/Rectangle

var carry : bool = false
var thrown : bool = false
var settled : bool = false

@warning_ignore("unused_parameter")
func _physics_process(delta):
	if animationExplo.frame == 3:
		explrectangle.visible = false
		explosionCol.set_deferred("disabled", true)
	elif animationExplo.frame == 8:
		queue_free()

func _on_timer_timeout() -> void:
	thrown = false

func _ready():
	set_meta("ExplodingBarrel", false)
	explosionCol.set_deferred("disabled", true)
	animationExplo.animation = "explosion"
	animationExplo.frame = 0
	if carry:
		impulse_collision_shape_2d.set_deferred("disabled", true)
	
	rectangle.visible = SettingsDataContainer.get_show_hitboxes() && !carry
	rectangle.size.y = 10
	feetrectangle.visible = SettingsDataContainer.get_show_hitboxes() && !carry
	feetrectangle.size.y = 46.5
	explrectangle.visible = false
	explrectangle.size.y = 86

func explosion() -> void:
	if exploding: return
	if carry: Global.follower_array[0].carrying = false
	call_deferred("set_freeze_enabled", true)
	expl_collision_shape_2d.scale.x = Global.expl_B_size_mod
	expl_collision_shape_2d.scale.y = Global.expl_B_size_mod
	$AnimatedSprite2D.scale.x = Global.expl_B_size_mod + 0.5
	$AnimatedSprite2D.scale.y = Global.expl_B_size_mod + 0.5
	linear_velocity = Vector2.ZERO
	angular_velocity = 0
	sleeping = true
	exploding = true
	impulse_collision_shape_2d.set_deferred("disabled", true)
	explosionCol.set_deferred("disabled", false)
	animationExplo.play("explosion")
	explrectangle.visible = SettingsDataContainer.get_show_hitboxes()

@warning_ignore("unused_parameter")
func _input(event: InputEvent) -> void:
	if carry:
		var grapple_input_pressed : bool = Input.is_action_just_pressed("throw_cont") || \
		Input.is_action_just_pressed("throw")
		if grapple_input_pressed:
			carry = false
			var contr_dir : Vector2 = Vector2.ZERO
			if Global.using_cont && SettingsDataContainer.get_controller_aim_toggle():
				contr_dir.y += -1 * Input.get_action_raw_strength("up_cont_aim")
				contr_dir.y += Input.get_action_raw_strength("down_cont_aim")
				contr_dir.x += Input.get_action_raw_strength("right_cont_aim")
				contr_dir.x += -1 * Input.get_action_raw_strength("left_cont_aim")
				if contr_dir.length() < 0.1:
					contr_dir = Global.follower_array[0].velocityRigid
				contr_dir = contr_dir.normalized()
			elif !Global.using_cont && SettingsDataContainer.get_mouse_aim_toggle():
				contr_dir = (get_global_mouse_position() - global_position).normalized()
			else:
				contr_dir = Global.follower_array[0].velocityRigid.normalized()
			if contr_dir == Vector2.ZERO:
				contr_dir.y = -1
			queue_free()
			Global.follower_array[0].carrying = false
			var new_expl_barrel : RigidBody2D = Globalpreload.EXPLBARREL_INST.duplicate()
			var nodeanchor : Node2D = Global.follower_array[0].get_node(
				"TopCollisionPolygon2D/CarryingNode")
			new_expl_barrel.global_position = nodeanchor.global_position
			new_expl_barrel.thrown = true
			new_expl_barrel.apply_central_impulse(
				contr_dir*Global.expl_B_impulse_mod)
			get_tree().root.get_node("Level/Ysort").call_deferred(
				"add_child", new_expl_barrel)
			Global.expl_B_speed_penalty_curr = 1
			Global.updatelabels = true

# impulse
@warning_ignore("unused_parameter")
func _on_impulse_body_entered(body):
	if body == self: return
	var metalist : PackedStringArray = body.get_meta_list()
	if exploding: return
#	if not_moving && "Player" in metalist:
	if "Player" in metalist and !carry and !thrown and !Global.follower_array[0].carrying:
		Global.follower_array[0].carrying = true
		Global.updatelabels = true
		var nodeanchor : Node2D = Global.follower_array[0].get_node(
			"TopCollisionPolygon2D/CarryingNode")
		queue_free()
		var new_expl_barrel : RigidBody2D = Globalpreload.EXPLBARREL_INST.duplicate()
		new_expl_barrel.carry = true
		new_expl_barrel.freeze = true
		new_expl_barrel.sleeping = true
		nodeanchor.call_deferred("add_child", new_expl_barrel)
		Global.expl_B_speed_penalty_curr = Global.expl_B_speed_penalty
	for i in ["Element", "Border"]:
		if i in metalist:
			explosion()

func _on_impulse_area_entered(area):
	var metalist : PackedStringArray = area.get_meta_list()
	if exploding: return
	for i in ["Car", "Item", "ExplodingBarrelImpulse"]:
		if i in metalist:
			explosion()
	
# explosions
# bodies
func _on_explosionbarrelexplosion_body_entered(body):
	var metalist : PackedStringArray = body.get_meta_list()
	if "Player" in metalist:
		if !body.shield_up:
			Global.defeat()
		else:
			body.shield_comp = true
	elif "Follower" in metalist:
		body.remove_follower()
	for i in ["Element"]:
		if i in metalist:
			body.queue_free()
	
func _on_explosionbarrelexplosion_body_exited(body):
	var metalist : PackedStringArray = body.get_meta_list()
	if "Player" in metalist:
		body.shield_gone = true
		body.shield_comp = false

# areas
func _on_explosionbarrelexplosion_area_entered(area):
	var metalist : PackedStringArray = area.get_meta_list()
	for i in ["Car", "Item", "Grapplehead"]:
		if i in metalist:
			area.queue_free()
	if "ExplodingBarrelImpulse" in metalist:
		area.explosion()
	elif "Hole" in metalist:
		if !area.crater:
			area.crater = true
			area.global_position.y -= 50
			area.get_node("Sprite2D").scale *= 3
			area.get_node("Sprite2D").position.y += 50
			area.get_node("CollisionShape2D").scale *= 4
			area.get_node("CollisionShape2D").position.y += 50

func _on_feet_area_entered(area: Area2D) -> void:
	var metalist : PackedStringArray = area.get_meta_list()
	for i in ["Hole"]:
		if i in metalist:
			explosion()


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	if !SettingsDataContainer.get_logbook_dict("Objects", "ExplBarrel")[0]:
		SettingsSignalBus.emit_on_logbook_dict_set("Objects", "ExplBarrel", true, 0)
