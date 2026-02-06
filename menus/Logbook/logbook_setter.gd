extends Control
@onready var sprite_2d: TextureRect = $HBoxContainer/Button/AspectRatioContainer/Sprite2D
@onready var mystery: TextureRect = $HBoxContainer/Button/AspectRatioContainer/Mystery
@onready var button: Button = $HBoxContainer/Button
@onready var unlocked : bool = false
@onready var polygon_2d: Polygon2D = $HBoxContainer/Button/AspectRatioContainer/Polygon2D
@export var type : String
@export var object : String
@onready var desc : String = ""

func _ready() -> void:
	if object:
		unlocked = SettingsDataContainer.get_logbook_dict(type ,object)[0]
		if unlocked:
			set_properties()
			desc_stat_addons()
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

func desc_stat_addons() -> void:
	var text : String = SettingsDataContainer.get_logbook_dict_tooltip(type, object)
	var addedtxtarr : Array[String] = []
	var addedtxtarridx : Array[int] = []
	match type:
		"Items", "Curses":
			addedtxtarr.append("Collected")
			addedtxtarridx.append(0)
		"Objects":
			match object:
				"ExplBarrel":
					addedtxtarr.append("Exploded")
					addedtxtarridx.append(0)
					addedtxtarr.append("Thrown")
					addedtxtarridx.append(1)
					addedtxtarr.append("Deaths")
					addedtxtarridx.append(2)
				"Barrel":
					addedtxtarr.append("Exploded")
					addedtxtarridx.append(0)
				"Dumpster":
					addedtxtarr.append("Exploded")
					addedtxtarridx.append(0)
				"Hole_Sidewalk_Street":
					addedtxtarr.append("Exploded")
					addedtxtarridx.append(0)
					addedtxtarr.append("Deaths")
					addedtxtarridx.append(2)
				"Cars":
					addedtxtarr.append("Exploded")
					addedtxtarridx.append(0)
					addedtxtarr.append("Deaths")
					addedtxtarridx.append(2)
				"LineOfDeath":
					addedtxtarr.append("Deaths")
					addedtxtarridx.append(2)
	if !addedtxtarr.is_empty():
		for i in range(0, addedtxtarr.size()):
			text += "\n{modifier}: {stat}".format({"modifier":addedtxtarr[i],
					"stat":SettingsDataContainer.get_logbook_dict_stats(
						type, object, addedtxtarridx[i])})
	
	desc = text
	

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
			desc,
			sprite_2d.texture)
