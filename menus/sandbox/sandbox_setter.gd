extends Control

@export var object : String 
@export var sandbox_type : String
@export var group : String
@onready var timer: Timer = $Timer
@onready var texture_array : Array[Texture2D] = []
@onready var index : int = 0
@onready var label: Label = $HBoxContainer/Button/HBoxContainer/label
@onready var sprite_2d: TextureRect = $HBoxContainer/Button/HBoxContainer/Sprite2D
@onready var h_slider: HSlider = $HBoxContainer/Button/HBoxContainer/HSlider
@onready var chance_num: Label = $HBoxContainer/Button/HBoxContainer/Chance_Num
@onready var button: Button = $HBoxContainer/Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.visible = false
	sprite_2d.visible = true
	set_properties()
	h_slider.value_changed.connect(on_value_changed)
	add_to_group(group)

func _on_button_pressed() -> void:
	if button.has_focus():
		h_slider.grab_focus.call_deferred()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") && h_slider.has_focus():
		button.grab_focus.call_deferred()

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
		"Cleanse" :
			set_sandbox_option(object, "Items", 999, 
			"res://RogueFroggerAssets/RFAssets/Level/cleanse.png")
		"Hole" :
			set_sandbox_option(object, "Items", 999, 
			"res://RogueFroggerAssets/RFAssets/Hole/RORhole.png")
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
		"Hole_Sidewalk" : 
			set_sandbox_option(object, "General", 999, 
			"res://RogueFroggerAssets/RFAssets/Hole/RORhole.png")
		"None_Street" : 
			set_sandbox_option(object, "Street", 999, 
			"None")
		"Hole_Street" : 
			set_sandbox_option(object, "Street", 999, 
			"res://RogueFroggerAssets/RFAssets/Hole/RORhole.png")
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
		"HoleShop" : 
			set_sandbox_option(object, "Shop", 1, 
			"res://RogueFroggerAssets/RFAssets/Hole/RORhole.png")
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
		"HoleGamba" : 
			set_sandbox_option(object, "Gamba", 1, 
			"res://RogueFroggerAssets/RFAssets/Hole/RORhole.png")
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
		"HoleMulti" : 
			set_sandbox_option(object, "Multi", 999, 
			"res://RogueFroggerAssets/RFAssets/Hole/RORhole.png")
		_: print("set texture string was not there: ", object)

func set_sandbox_option(topic : String, type : String, maxint : int, texture : String) -> void:
	sandbox_type = type
	match texture:
		"Multi": set_Multi()
		"Shop": set_label("Shop")
		"None": set_label("None")
		"Items": set_label("Items")
		_: set_texture(texture)
	
	set_slider(
		maxint,
		SettingsDataContainer.get_sandbox_dict(type, topic)
		)
		

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
	chance_num.text = str(curr)

func on_value_changed(value: float) -> void:
	chance_num.text = str(value)

func save_value() -> void:
	SettingsSignalBus.emit_on_sandbox_dict_set(
		sandbox_type, object, int(h_slider.value)
		)

func reset_value() -> void:
	h_slider.value = SettingsDataContainer.get_sandbox_dict(
		sandbox_type, object, true
		)

func _on_timer_timeout() -> void:
	index = (index + 1) % 3
	sprite_2d.texture = texture_array[index]
