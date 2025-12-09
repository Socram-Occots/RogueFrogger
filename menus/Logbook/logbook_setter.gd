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
	
func set_texture(texture_path : String) -> void:
	sprite_2d.texture = load(texture_path)

func set_properties() -> void:
	match object:
		"PlayerSpeed" : 
			set_texture( 
			"res://RogueFroggerAssets/RFAssets/Level/speedometer.png")
		"GlideBoots" : 
			set_texture(
			"res://RogueFroggerAssets/RFAssets/Level/glideboots.png")
		"Dash" : 
			set_texture(
			"res://RogueFroggerAssets/RFAssets/Level/fire-dash.png")
		"expl_B" :
			set_texture(
			"res://RogueFroggerAssets/RFAssets/ExplodingBarrel/explbarrelicon.png")
		"Grapple" : 
			set_texture(
			"res://RogueFroggerAssets/RFAssets/Level/grappleropeicon.png")
		"Follower" : 
			set_texture( 
			"res://RogueFroggerAssets/RFAssets/Level/follower.png")
		"Gamba" :
			set_texture( 
			"res://RogueFroggerAssets/RFAssets/Level/gamba.png")
		"Shield" : 
			set_texture(
			"res://RogueFroggerAssets/RFAssets/PlayerShield/vibrating-shield.png")
		"Shrink" : 
			set_texture( 
			"res://RogueFroggerAssets/RFAssets/Level/shrink.png")
		"Cleanse" :
			set_texture( 
			"res://RogueFroggerAssets/RFAssets/Level/cleanse.png")
		"Hole" :
			set_texture( 
			"res://RogueFroggerAssets/RFAssets/Level/holeicon.png")
		"ExplBarrel" : 
			set_texture( 
			"res://RogueFroggerAssets/RFAssets/ExplodingBarrel/exploding_barrel_1.png")
		"Dumpster" : 
			set_texture( 
			"res://RogueFroggerAssets/RFAssets/Level/dumpster_ROR.png")
		"Barrel" : 
			set_texture( 
			"res://RogueFroggerAssets/RFAssets/Level/BarrelPreview.png")
		"Hole_Sidewalk_Street" : 
			set_texture( 
			"res://RogueFroggerAssets/RFAssets/Hole/RORhole.png")
		"Slow" : 
			set_texture(
			"res://RogueFroggerAssets/RFAssets/Level/slow.png")
		"Grow" : 
			set_texture(
			"res://RogueFroggerAssets/RFAssets/Level/grow.png")
		"LongTeleport" : 
			set_texture( 
			"res://RogueFroggerAssets/RFAssets/Level/longteleport.png")
		"ShortTeleport" : 
			set_texture( 
			"res://RogueFroggerAssets/RFAssets/Level/shortteleport.png")
		"DVDBounce" : 
			set_texture( 
			"res://RogueFroggerAssets/RFAssets/Level/dvdbounceicon.png")
		_: print("set texture string was not there for logbook: ", object)

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	if unlocked and !SettingsDataContainer.get_logbook_dict(type ,object)[1]:
		SettingsSignalBus.emit_on_logbook_dict_set(type, object, true, 1)
