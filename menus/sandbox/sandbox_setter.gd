extends Control

@export var object : String 
@onready var sprite_2d: TextureRect = $HBoxContainer/Sprite2D
@onready var h_slider: HSlider = $HBoxContainer/HSlider
@onready var chance_num: Label = $HBoxContainer/Chance_Num
@onready var timer: Timer = $Timer
@onready var texture_array : Array[Texture2D] = []
@onready var index : int = 0
@onready var label: Label = $HBoxContainer/label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.visible = false
	sprite_2d.visible = true
	match object:
		"PlayerSpeed" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/speedometer.png")
		"GlideBoots" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/glideboots.png")
		"Dash" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/fire-dash.png")
		"expl_B" : 
			set_texture("res://RogueFroggerAssets/RFAssets/ExplodingBarrel/explbarrelicon.png")
		"Grapple" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/grappleropeicon.png")
		"Follower" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/follower.png")
		"Gamba" :
			set_texture("res://RogueFroggerAssets/RFAssets/Level/gamba.png")
		"Shield" : 
			set_texture("res://RogueFroggerAssets/RFAssets/PlayerShield/vibrating-shield.png")
		"Shrink" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/shrink.png")
		"Slow" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/slow.png")
		"Grow" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/grow.png")
		"LongTeleport" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/longteleport.png")
		"ShortTeleport" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/shortteleport.png")
		"Cleanse" :
			set_texture("res://RogueFroggerAssets/RFAssets/Level/cleanse.png")
		"DVDBounce" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/dvdbounceicon.png")
		"ExplBarrel" : 
			set_texture("res://RogueFroggerAssets/RFAssets/ExplodingBarrel/exploding_barrel_1.png")
		"Dumpster" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/dumpster_ROR.png")
		"Barrel" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/BarrelPreview.png")
		"Multi" : 
			set_Multi()
		"Shop" : 
			set_label("Shop")
		"Items" :
			set_label("Items")
		"None" : 
			set_label("None")
		"PlayerSpeedShop" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/speedometer.png")
		"GlideBootsShop" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/glideboots.png")
		"DashShop" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/fire-dash.png")
		"expl_BShop" : 
			set_texture("res://RogueFroggerAssets/RFAssets/ExplodingBarrel/explbarrelicon.png")
		"GrappleShop" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/grappleropeicon.png")
		"FollowerShop" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/follower.png")
		"GambaShop" :
			set_texture("res://RogueFroggerAssets/RFAssets/Level/gamba.png")
		"ShieldShop" : 
			set_texture("res://RogueFroggerAssets/RFAssets/PlayerShield/vibrating-shield.png")
		"ShrinkShop" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/shrink.png")
		"SlowShop" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/slow.png")
		"GrowShop" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/grow.png")
		"LongTeleportShop" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/longteleport.png")
		"ShortTeleportShop" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/shortteleport.png")
		"CleanseShop" :
			set_texture("res://RogueFroggerAssets/RFAssets/Level/cleanse.png")
		"DVDBounceShop" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/dvdbounceicon.png")
		"PlayerSpeedGamba" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/speedometer.png")
		"GlideBootsGamba" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/glideboots.png")
		"DashGamba" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/fire-dash.png")
		"expl_BGamba" : 
			set_texture("res://RogueFroggerAssets/RFAssets/ExplodingBarrel/explbarrelicon.png")
		"GrappleGamba" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/grappleropeicon.png")
		"FollowerGamba" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/follower.png")
		"ShrinkGamba" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/shrink.png")
		"SlowGamba" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/slow.png")
		"GrowGamba" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/grow.png")
		"LongTeleportGamba" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/longteleport.png")
		"ShortTeleportGamba" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/shortteleport.png")
		"CleanseGamba" :
			set_texture("res://RogueFroggerAssets/RFAssets/Level/cleanse.png")
		"DVDBounceGamba" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/dvdbounceicon.png")
		"PlayerSpeedMulti" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/speedometer.png")
		"GlideBootsMulti" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/glideboots.png")
		"DashMulti" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/fire-dash.png")
		"expl_BMulti" : 
			set_texture("res://RogueFroggerAssets/RFAssets/ExplodingBarrel/explbarrelicon.png")
		"GrappleMulti" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/grappleropeicon.png")
		"FollowerMulti" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/follower.png")
		"GambaMulti" :
			set_texture("res://RogueFroggerAssets/RFAssets/Level/gamba.png")
		"ShieldMulti" : 
			set_texture("res://RogueFroggerAssets/RFAssets/PlayerShield/vibrating-shield.png")
		"ShrinkMulti" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/shrink.png")
		"SlowMulti" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/slow.png")
		"GrowMulti" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/grow.png")
		"LongTeleportMulti" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/longteleport.png")
		"ShortTeleportMulti" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/shortteleport.png")
		"CleanseMulti" :
			set_texture("res://RogueFroggerAssets/RFAssets/Level/cleanse.png")
		"DVDBounceMulti" : 
			set_texture("res://RogueFroggerAssets/RFAssets/Level/dvdbounceicon.png")
		_: print("set texture string was not there: ", object)

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	index = (index + 1) % 3
	sprite_2d.texture = texture_array[index]
