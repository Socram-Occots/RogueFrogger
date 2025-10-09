extends Control

@export var object : String 
@export var sandbox_type : String
@onready var sprite_2d: TextureRect = $HBoxContainer/Sprite2D
@onready var h_slider: HSlider = $HBoxContainer/HSlider
@onready var chance_num: Label = $HBoxContainer/Chance_Num
@onready var timer: Timer = $Timer
@onready var texture_array : Array[Texture2D] = []
@onready var index : int = 0
@onready var label: Label = $HBoxContainer/label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	h_slider.value_changed.connect(on_value_changed)
	label.visible = false
	sprite_2d.visible = true
	set_properties()
	

func set_properties() -> void:
	match object:
		"PlayerSpeed" : 
			set_sandbox_option(object, "Items", 999, 
			"res://RogueFroggerAssets/RFAssets/Level/speedometer.png")
		"GlideBoots" : 
			set_sandbox_option(object, "Items", 999, 
			"res://RogueFroggerAssets/RFAssets/Level/glideboots.png")
		"Dash" : 
			set_sandbox_option(object, "Items", 999, 
			"res://RogueFroggerAssets/RFAssets/Level/fire-dash.png")
		"expl_B" :
			set_sandbox_option(object, "Items", 999, 
			"res://RogueFroggerAssets/RFAssets/ExplodingBarrel/explbarrelicon.png")
		"Grapple" : 
			set_sandbox_option(object, "Items", 999, 
			"res://RogueFroggerAssets/RFAssets/Level/grappleropeicon.png")
		"Follower" : 
			set_sandbox_option(object, "Items", 999, 
			"res://RogueFroggerAssets/RFAssets/Level/follower.png")
		"Gamba" :
			set_sandbox_option(object, "Items", 999, 
			"res://RogueFroggerAssets/RFAssets/Level/gamba.png")
		"Shield" : 
			set_sandbox_option(object, "Items", 999, 
			"res://RogueFroggerAssets/RFAssets/PlayerShield/vibrating-shield.png")
		"Shrink" : 
			set_sandbox_option(object, "Items", 999, 
			"res://RogueFroggerAssets/RFAssets/Level/shrink.png")
		"Multi" : 
			set_sandbox_option(object, "Items", 999, 
			"Multi")
		"ExplBarrel" : 
			set_sandbox_option(object, "General", 999, 
			"res://RogueFroggerAssets/RFAssets/ExplodingBarrel/exploding_barrel_1.png")
		"Dumpster" : 
			set_sandbox_option(object, "General", 999, 
			"res://RogueFroggerAssets/RFAssets/Level/dumpster_ROR.png")
		"Barrel" : 
			set_sandbox_option(object, "General", 999, 
			"res://RogueFroggerAssets/RFAssets/Level/BarrelPreview.png")
		"Shop" : 
			set_sandbox_option(object, "General", 999, 
			"Shop")
		"Items" :
			set_sandbox_option(object, "General", 999, 
			"Items")
		"None" : 
			set_sandbox_option(object, "General", 999, 
			"None")
		"PlayerSpeedShop" : 
			set_sandbox_option(object, "Shop", 1, 
			"res://RogueFroggerAssets/RFAssets/Level/speedometer.png")
		"GlideBootsShop" : 
			set_sandbox_option(object, "Shop", 1, 
			"res://RogueFroggerAssets/RFAssets/Level/glideboots.png")
		"DashShop" : 
			set_sandbox_option(object, "Shop", 1, 
			"res://RogueFroggerAssets/RFAssets/Level/fire-dash.png")
		"expl_BShop" : 
			set_sandbox_option(object, "Shop", 1, 
			"res://RogueFroggerAssets/RFAssets/ExplodingBarrel/explbarrelicon.png")
		"GrappleShop" : 
			set_sandbox_option(object, "Shop", 1, 
			"res://RogueFroggerAssets/RFAssets/Level/grappleropeicon.png")
		"FollowerShop" : 
			set_sandbox_option(object, "Shop", 1, 
			"res://RogueFroggerAssets/RFAssets/Level/follower.png")
		"GambaShop" :
			set_sandbox_option(object, "Shop", 1, 
			"res://RogueFroggerAssets/RFAssets/Level/gamba.png")
		"ShieldShop" : 
			set_sandbox_option(object, "Shop", 1, 
			"res://RogueFroggerAssets/RFAssets/PlayerShield/vibrating-shield.png")
		"ShrinkShop" : 
			set_sandbox_option(object, "Shop", 1, 
			"res://RogueFroggerAssets/RFAssets/Level/shrink.png")
		"SlowShop" : 
			set_sandbox_option(object, "Shop", 1, 
			"res://RogueFroggerAssets/RFAssets/Level/slow.png")
		"GrowShop" : 
			set_sandbox_option(object, "Shop", 1, 
			"res://RogueFroggerAssets/RFAssets/Level/grow.png")
		"LongTeleportShop" : 
			set_sandbox_option(object, "Shop", 1, 
			"res://RogueFroggerAssets/RFAssets/Level/longteleport.png")
		"ShortTeleportShop" : 
			set_sandbox_option(object, "Shop", 1, 
			"res://RogueFroggerAssets/RFAssets/Level/shortteleport.png")
		"CleanseShop" :
			set_sandbox_option(object, "Shop", 1, 
			"res://RogueFroggerAssets/RFAssets/Level/cleanse.png")
		"DVDBounceShop" : 
			set_sandbox_option(object, "Shop", 1, 
			"res://RogueFroggerAssets/RFAssets/Level/dvdbounceicon.png")
		"PlayerSpeedGamba" : 
			set_sandbox_option(object, "Gamba", 1, 
			"res://RogueFroggerAssets/RFAssets/Level/speedometer.png")
		"GlideBootsGamba" : 
			set_sandbox_option(object, "Gamba", 1, 
			"res://RogueFroggerAssets/RFAssets/Level/glideboots.png")
		"DashGamba" : 
			set_sandbox_option(object, "Gamba", 1, 
			"res://RogueFroggerAssets/RFAssets/Level/fire-dash.png")
		"expl_BGamba" : 
			set_sandbox_option(object, "Gamba", 1, 
			"res://RogueFroggerAssets/RFAssets/ExplodingBarrel/explbarrelicon.png")
		"GrappleGamba" : 
			set_sandbox_option(object, "Gamba", 1, 
			"res://RogueFroggerAssets/RFAssets/Level/grappleropeicon.png")
		"FollowerGamba" : 
			set_sandbox_option(object, "Gamba", 1, 
			"res://RogueFroggerAssets/RFAssets/Level/follower.png")
		"ShrinkGamba" : 
			set_sandbox_option(object, "Gamba", 1, 
			"res://RogueFroggerAssets/RFAssets/Level/shrink.png")
		"SlowGamba" : 
			set_sandbox_option(object, "Gamba", 1, 
			"res://RogueFroggerAssets/RFAssets/Level/slow.png")
		"GrowGamba" : 
			set_sandbox_option(object, "Gamba", 1, 
			"res://RogueFroggerAssets/RFAssets/Level/grow.png")
		"LongTeleportGamba" : 
			set_sandbox_option(object, "Gamba", 1, 
			"res://RogueFroggerAssets/RFAssets/Level/longteleport.png")
		"ShortTeleportGamba" : 
			set_sandbox_option(object, "Gamba", 1, 
			"res://RogueFroggerAssets/RFAssets/Level/shortteleport.png")
		"CleanseGamba" :
			set_sandbox_option(object, "Gamba", 1, 
			"res://RogueFroggerAssets/RFAssets/Level/cleanse.png")
		"DVDBounceGamba" : 
			set_sandbox_option(object, "Gamba", 1, 
			"res://RogueFroggerAssets/RFAssets/Level/dvdbounceicon.png")
		"PlayerSpeedMulti" : 
			set_sandbox_option(object, "Multi", 999, 
			"res://RogueFroggerAssets/RFAssets/Level/speedometer.png")
		"GlideBootsMulti" : 
			set_sandbox_option(object, "Multi", 999, 
			"res://RogueFroggerAssets/RFAssets/Level/glideboots.png")
		"DashMulti" : 
			set_sandbox_option(object, "Multi", 999, 
			"res://RogueFroggerAssets/RFAssets/Level/fire-dash.png")
		"expl_BMulti" : 
			set_sandbox_option(object, "Multi", 999, 
			"res://RogueFroggerAssets/RFAssets/ExplodingBarrel/explbarrelicon.png")
		"GrappleMulti" : 
			set_sandbox_option(object, "Multi", 999, 
			"res://RogueFroggerAssets/RFAssets/Level/grappleropeicon.png")
		"FollowerMulti" : 
			set_sandbox_option(object, "Multi", 999, 
			"res://RogueFroggerAssets/RFAssets/Level/follower.png")
		"GambaMulti" :
			set_sandbox_option(object, "Multi", 999, 
			"res://RogueFroggerAssets/RFAssets/Level/gamba.png")
		"ShieldMulti" : 
			set_sandbox_option(object, "Multi", 999, 
			"res://RogueFroggerAssets/RFAssets/PlayerShield/vibrating-shield.png")
		"ShrinkMulti" : 
			set_sandbox_option(object, "Multi", 999, 
			"res://RogueFroggerAssets/RFAssets/Level/shrink.png")
		"SlowMulti" : 
			set_sandbox_option(object, "Multi", 999, 
			"res://RogueFroggerAssets/RFAssets/Level/slow.png")
		"GrowMulti" : 
			set_sandbox_option(object, "Multi", 999, 
			"res://RogueFroggerAssets/RFAssets/Level/grow.png")
		"LongTeleportMulti" : 
			set_sandbox_option(object, "Multi", 999, 
			"res://RogueFroggerAssets/RFAssets/Level/longteleport.png")
		"ShortTeleportMulti" : 
			set_sandbox_option(object, "Multi", 999, 
			"res://RogueFroggerAssets/RFAssets/Level/shortteleport.png")
		"CleanseMulti" :
			set_sandbox_option(object, "Multi", 999, 
			"res://RogueFroggerAssets/RFAssets/Level/cleanse.png")
		"DVDBounceMulti" : 
			set_sandbox_option(object, "Multi", 999, 
			"res://RogueFroggerAssets/RFAssets/Level/dvdbounceicon.png")
		_: print("set texture string was not there: ", object)

func set_sandbox_option(topic : String, type : String, maxint : int, texture : String) -> void:
	match texture:
		"Multi": set_Multi()
		"Shop": set_label("Shop")
		"None": set_label("None")
		"Items": set_label("Items")
		_: set_texture(texture)
	
	match type:
		"General": 
			set_slider(
				maxint,
				SettingsDataContainer.get_
		"Items":
			set_slider(maxint,)
		"MultiItem":
			set_slider(maxint,)
		"Gamba":
			set_slider(maxint,)
		"Shop":
			set_slider(maxint,)
	sandbox_type = type

func set_texture(texture_path : String) -> void:
	sprite_2d.texture = load(texture_path)
	
func set_Multi() -> void:
	texture_array.resize(3)
	texture_array[0] = load("res://RogueFroggerAssets/RFAssets/Level/speedometer.png")
	texture_array[1] = load("res://RogueFroggerAssets/RFAssets/Level/fire-dash.png")
	texture_array[2] = load("res://RogueFroggerAssets/RFAssets/Level/dvdbounceicon.png")
	sprite_2d.texture = texture_array[index]
	label.text = "Multi-Item"
	label.visible = true
	timer.start()

func set_label(label_string : String) -> void:
	label.text = label_string
	label.visible = true
	sprite_2d.texture = null
	sprite_2d.visible = false

func set_slider(limit : int = 999, curr : int = 0) -> void:
	h_slider.max_value = limit
	h_slider.value = curr

func on_value_changed(value: float) -> void:
	match sandbox_type:
		"General": 
			SettingsSignalBus.emit
		"Items":
			SettingsSignalBus.emit
		"MultiItem":
			SettingsSignalBus.emit
		"Gamba":
			SettingsSignalBus.emit
		"Shop":
			SettingsSignalBus.emit

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	index = (index + 1) % 3
	sprite_2d.texture = texture_array[index]
