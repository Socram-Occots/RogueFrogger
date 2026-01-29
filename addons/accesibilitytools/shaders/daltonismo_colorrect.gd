extends ColorRect

func _ready():
	GlobalAccesibilitySignal.connect("change_shader", Callable(self, "_on_shader_changed"))
	if GlobalAccesibilitySignal.selected_shader == null:
		pass
	else:
		_on_shader_changed(GlobalAccesibilitySignal.selected_shader)
	GlobalAccesibilitySignal.emit_change_shader(
		SettingsDataContainer.get_colorblind_mode())

func _on_shader_changed(shader: Shader):
	if shader:
		var material = ShaderMaterial.new()
		material.shader = shader
		self.material = material
	else:
		self.material = null 
