extends Node

signal change_shader(shader)

var selected_shader : Shader = null
var color_blind_selected : int = 0
var scene_color_data := []

func emit_change_shader(index: int):
	match index:
		0:
			selected_shader = Globalpreload.shader_normal
		1:
			selected_shader = Globalpreload.shader_deuteranopia
		2:
			selected_shader = Globalpreload.shader_protanopia
		3:
			selected_shader = Globalpreload.shader_tritanopia
		_:
			print("Colorblind shader missing: ", index)
	color_blind_selected = index
	emit_signal("change_shader", selected_shader)

func add_scene_data(name: String, scene_path: String, target_color: Color) -> void:
	scene_color_data.append([name, scene_path, target_color])

func get_scene_data(index: int) -> Array:
	if index >= 0 and index < scene_color_data.size():
		return scene_color_data[index]
	return []
