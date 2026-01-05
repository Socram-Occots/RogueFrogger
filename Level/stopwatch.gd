extends Label

@onready var time_elapsed : float = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	time_elapsed += delta
	text = "%d:%d:%.3f" % \
	[time_elapsed / 3600, time_elapsed / 60, fmod(time_elapsed, 60)] 
	Global.stopwatch_time = time_elapsed
