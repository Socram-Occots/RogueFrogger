extends Control
@onready var sprite_2d: TextureRect = $HBoxContainer/Button/AspectRatioContainer/Sprite2D
@onready var mystery: TextureRect = $HBoxContainer/Button/AspectRatioContainer/Mystery
@onready var button: Button = $HBoxContainer/Button
@onready var unlocked : bool = false
@onready var polygon_2d: Polygon2D = $HBoxContainer/Button/AspectRatioContainer/Polygon2D
@export var type : String
@export var object : String

func _ready() -> void:
	if object:
		unlocked = SettingsDataContainer.get_logbook_dict(type ,object)[0]
		if unlocked:
			set_properties()
			if SettingsDataContainer.get_logbook_dict(type ,object)[1]:
				polygon_2d.visible = false
			else:
				polygon_2d.visible = true
		else:
			polygon_2d.visible = false
		mystery.visible = !unlocked
		sprite_2d.visible = unlocked
			
	else:
		visible = false
	
func set_texture(texture : Texture2D) -> void:
	sprite_2d.texture = texture

func set_properties() -> void:
	set_texture(Global.get_texture_icons(object, "Logbook"))

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	if unlocked and !SettingsDataContainer.get_logbook_dict(type ,object)[1]:
		SettingsSignalBus.emit_on_logbook_dict_set(type, object, true, 1)

func _on_button_pressed() -> void:
	if unlocked:
		get_tree().root.get_node("Logbook").set_text_tecture(
			SettingsDataContainer.get_logbook_dict_tooltip(type, object),
			sprite_2d.texture)
