extends Node2D

const POP : Resource = preload("res://menus/GameUI/popups.tscn")
@onready var not_entered : bool = true

@warning_ignore("unused_parameter")
func _on_area_1_body_entered(body: Node2D) -> void:
	if not_entered:
		not_entered = false
		# trigger highscore popup
		var high_score_pop_up : Control = POP.instantiate()
		high_score_pop_up.get_node("dashpopup/Label").text = "New High Score!"
		get_node("/root/Level/CanvasLayer").add_child(high_score_pop_up)
