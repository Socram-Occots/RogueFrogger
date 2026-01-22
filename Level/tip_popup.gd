extends VBoxContainer
@onready var title: Label = $TipPopupTitle/Label
@onready var description: Label = $TipPopupText/Label
@onready var queue : Array[String] = []
@onready var displaying : bool = false

func _ready() -> void:
	visible = false

func displayTip(titletext : String) -> void:
	visible = true
	title.text = titletext
	description.text = titletext
	displaying = true
	await get_tree().create_timer(4).timeout
	displaying = false
	visible = false
	queue.pop_front()
	if !queue.is_empty():
		displayTip(queue[0])
	
func loadTip(titleStr : String) -> void:
	queue.append(titleStr)
	if !displaying:
		displayTip(titleStr)
