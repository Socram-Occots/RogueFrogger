extends Node2D

@onready var duration = $duration

	
func start_dash(time):
	duration.wait_time = duration
	duration.start()
	
func is_dashing():
	return !duration.is_stopped()
