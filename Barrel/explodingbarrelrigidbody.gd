extends RigidBody2D

#@onready var not_moving = true
@onready var exploding : bool = false
@onready var animationExplo : AnimatedSprite2D = $AnimatedSprite2D
@onready var explosionCol : CollisionShape2D = $explosionbarrelexplosion/CollisionShape2D

@warning_ignore("unused_parameter")
func _physics_process(delta):
	if animationExplo.frame == 3:
		explosionCol.set_deferred("disabled", true)
	elif animationExplo.frame == 8:
		queue_free()

func _ready():
	set_meta("ExplodingBarrel", false)
	explosionCol.set_deferred("disabled", true)
	animationExplo.animation = "explosion"
	animationExplo.frame = 0
	
func explosion() -> void:
	if exploding: return
	$explosionbarrelexplosion/CollisionShape2D.scale.x = Global.expl_B_size_mod
	$explosionbarrelexplosion/CollisionShape2D.scale.y = Global.expl_B_size_mod
	$AnimatedSprite2D.scale.x = Global.expl_B_size_mod + 0.5
	$AnimatedSprite2D.scale.y = Global.expl_B_size_mod + 0.5
	linear_velocity = Vector2.ZERO
	angular_velocity = 0
	sleeping = true
	exploding = true
	$impulse/CollisionShape2D.set_deferred("disabled", true)
	$CollisionShape2D.set_deferred("disabled", true)
	explosionCol.set_deferred("disabled", false)
	animationExplo.play("explosion")

# impulse
@warning_ignore("unused_parameter")
func _on_impulse_body_entered(body):
	if body == self: return
#	print("impact")
	var metalist : PackedStringArray = body.get_meta_list()
	if exploding: return
#	if not_moving && "Player" in metalist:
	for i in ["Player", "Follower"]:
		if i in metalist:
			apply_impulse(Global.player_prev_vel * Global.expl_B_impulse_mod * get_physics_process_delta_time())
			#body.dashing = false
			break
	for i in ["Element", "ExplodingBarrel"]:
		if i in metalist:
			explosion()
		
func _on_impulse_area_entered(area):
	var metalist : PackedStringArray = area.get_meta_list()
	if exploding: return
	for i in ["Car", "Item"]:
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
	elif "ExplodingBarrel" in metalist:
		body.explosion()
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
	for i in ["Car", "Item", "ExplodingBarrel", "Grapplehead"]:
		if i in metalist:
			area.queue_free()
	if "ExplodingBarrel" in metalist:
		area.explosion()

func _on_feet_area_entered(area: Area2D) -> void:
	var metalist : PackedStringArray = area.get_meta_list()
	for i in ["Hole"]:
		if i in metalist:
			explosion()
