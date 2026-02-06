extends Area2D
@onready var crater : bool = false
@onready var coyote : bool = false
@onready var entered : bool = false
@onready var timer: Timer = $Timer
@onready var rectangle: Rectangle = $CollisionShape2D/Rectangle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.one_shot = true
	rectangle.visible = SettingsDataContainer.get_show_hitboxes()
	rectangle.size.y = 18

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass

func coyote_time() -> void:
	Global.hole_cool_down_bool = true
	Global.coyote_status_cool_down_bool = true
	coyote = true
	timer.start(Global.hole_coyote_time)

func _on_timer_timeout() -> void:
	if entered:
		Global.defeat("Objects", "Hole_Sidewalk_Street")
	coyote = false

func _on_area_entered(area: Area2D) -> void:
	var metalist : PackedStringArray = area.get_meta_list()
	if "Feet" in metalist:
		var body := area.get_parent()
		metalist = body.get_meta_list()
		if "Player" in metalist:
			entered = true
			if !body.shield_up && coyote:
				Global.defeat("Objects", "Hole_Sidewalk_Street")
			elif body.shield_up:
				body.shield_comp = true
			elif Global.hole_mod > 0 && !Global.hole_cool_down_bool:
				coyote_time()
			else:
				Global.defeat("Objects", "Hole_Sidewalk_Street")
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
			timer.stop()
			coyote = false
			Global.coyote_status_cool_down_bool = false
			if body.shield_up:
				body.shield_gone = true
				body.shield_comp = false

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	if !SettingsDataContainer.get_logbook_dict("Objects", "Hole_Sidewalk_Street")[0]:
		SettingsSignalBus.emit_on_logbook_dict_set("Objects", "Hole_Sidewalk_Street", true, 0)
