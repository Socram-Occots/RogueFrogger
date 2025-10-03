extends Label

@onready var sum = 0

func _ready():
	text = Global.version

func _process(delta: float) -> void:
	sum += delta
	text = str(sum)
