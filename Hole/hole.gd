extends Area2D
@onready var crater : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass

func _on_area_entered(area: Area2D) -> void:
	var metalist : PackedStringArray = area.get_meta_list()
	if "Feet" in metalist:
		var body := area.get_parent()
		metalist = body.get_meta_list()
		if "Player" in metalist:
			if !body.shield_up:
				Global.defeat()
			else:
				body.shield_comp = true
		elif "Follower" in metalist:
			body.remove_follower()
	elif "Car" in metalist && crater:
		area.queue_free()

func _on_area_exited(area: Area2D) -> void:
	var metalist : PackedStringArray = area.get_meta_list()
	if "Feet" in metalist:
		var body := area.get_parent()
		metalist = body.get_meta_list()
		if "Player" in metalist && body.shield_up:
			body.shield_gone = true
			body.shield_comp = false
