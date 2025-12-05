extends TextureRect
@export var itemtip : String
@onready var label: Label = $"../../../HBoxContainer/Label"

func show_tooltip() -> void:
	label.visible = true
	label.text = itemtip

func entered() -> void:
	show_tooltip() 
	self_modulate = Color(1,1,1,0.9)

func exited() -> void:
	self_modulate = Color(1,1,1,1)
	
func _on_focus_entered() -> void:
	entered()

func _on_focus_exited() -> void:
	exited()
	label.visible = false

func _on_mouse_entered() -> void:
	entered()

func _on_mouse_exited() -> void:
	exited()
	label.visible = false
