extends Area2D

@onready var activated : bool = false

@warning_ignore("unused_parameter")
func _process(delta):
	if position.y - Global.player_pos_y > 755:
		position.y = Global.player_pos_y + 755
		activated = true
	if activated:
		position.y -= 40 * delta

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	var metalist : PackedStringArray = body.get_meta_list()
	if "Player" in metalist:
		Global.defeat()
