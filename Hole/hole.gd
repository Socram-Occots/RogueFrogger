extends Area2D
@onready var crater : bool = false
@onready var coyote : bool = false
@onready var entered : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass

func coyote_time() -> void:
	Global.hole_cool_down_bool = true
	coyote = true
	await get_tree().create_timer(Global.hole_coyote_time).timeout
	if entered:
		Global.defeat()

func _on_area_entered(area: Area2D) -> void:
	var metalist : PackedStringArray = area.get_meta_list()
	if "Feet" in metalist:
		var body := area.get_parent()
		metalist = body.get_meta_list()
		if "Player" in metalist:
			entered = true
			if !body.shield_up && coyote:
				Global.defeat()
			elif body.shield_up && (coyote || Global.hole_mod < 1):
				body.shield_comp = true
			elif Global.hole_mod > 0 && !Global.hole_cool_down_bool:
				coyote_time()
			else:
				Global.defeat()
		elif "Follower" in metalist:
			body.remove_follower()
	elif "Car" in metalist && crater:
		area.queue_free()

func _on_area_exited(area: Area2D) -> void:
	var metalist : PackedStringArray = area.get_meta_list()
	if "Feet" in metalist:
		var body := area.get_parent()
		metalist = body.get_meta_list()
		if "Player" in metalist:
			entered = false
			if body.shield_up:
				body.shield_gone = true
				body.shield_comp = false
