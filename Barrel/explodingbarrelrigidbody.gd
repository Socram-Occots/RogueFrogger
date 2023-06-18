extends RigidBody2D

#@onready var not_moving = true
@onready var exploding = false
@onready var animationExplo = $AnimatedSprite2D
@onready var explosionCol = $explosionbarrelexplosion/CollisionShape2D
@warning_ignore("unused_parameter")

func _process(delta):
	
	if animationExplo.frame == 3:
		explosionCol.set_deferred("disabled", true)

	if animationExplo.frame == 8:
		queue_free()

	if global_position.y - Global.player_pos_y > 777:
		queue_free()

func _ready():
	explosionCol.set_deferred("disabled", true)
	animationExplo.animation = "explosion"
	animationExplo.frame = 0
	
func explosion():
	if exploding: return
	linear_velocity = Vector2.ZERO
	angular_velocity = 0
	sleeping = true
	exploding = true
	$impulse/CollisionShape2D.set_deferred("disabled", true)
	$CollisionShape2D.set_deferred("disabled", true)
	explosionCol.set_deferred("disabled", false)
	animationExplo.play("explosion")

@warning_ignore("unused_parameter")
func _on_impulse_body_entered(body):
	if body == self: return
#	print("impact")
	var metalist = body.get_meta_list()
	if exploding: return
#	if not_moving && "Player" in metalist:
	if "Player" in metalist:
#		print(body.get_meta_list())
#		print(body.velocity)
#		not_moving = false
		apply_impulse(Global.player_prev_vel)
		body.dashing = false
	for i in ["Element", "ExplodingBarrel"]:
		if i in metalist:
			explosion()
		
func _on_impulse_area_entered(area):
	var metalist = area.get_meta_list()
	if exploding: return
	for i in ["Car", "Item"]:
		if i in metalist:
			explosion()
	
func _on_explosionbarrelexplosion_body_entered(body):
	var metalist = body.get_meta_list()
	if "Player" in metalist:
		print("explosion")
		get_tree().change_scene_to_file("res://GameUI/game_ui.tscn")
	for i in ["Element"]:
		if i in metalist:
			body.queue_free()
	if "ExplodingBarrel" in metalist:
		body.explosion()
		
func _on_explosionbarrelexplosion_area_entered(area):
	var metalist = area.get_meta_list()
	for i in ["Car", "Item", "ExplodingBarrel"]:
		if i in metalist:
			area.queue_free()
	if "ExplodingBarrel" in metalist:
		area.explosion()
