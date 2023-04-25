extends ColorRect

func _ready():
	while(position.y > 600):
		position.y -= 0.1
		await $dashpopup/the_tims.create_timer(0.05).timeout
	await $dashpopup/the_tims.create_timer(2).timeout
	while(position.y < 720):
		position.y -= 0.1
		await $dashpopup/the_tims.create_timer(0.05).timeout
	queue_free()
