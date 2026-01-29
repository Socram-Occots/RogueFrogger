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
			"", Globalpreload.PlayerSpeed_t)
		"GlideBoots" : 
			set_sandbox_option(object, "Items", 999, 
			"", Globalpreload.GlideBoots_t)
		"Dash" : 
			set_sandbox_option(object, "Items", 999, 
			"", Globalpreload.Dash_t)
		"expl_B" :
			set_sandbox_option(object, "Items", 999, 
			"", Globalpreload.expl_B_t)
		"Grapple" : 
			set_sandbox_option(object, "Items", 999, 
			"", Globalpreload.Grapple_t)
		"Follower" : 
			set_sandbox_option(object, "Items", 999, 
			"", Globalpreload.Follower_t)
		"Gamba" :
			set_sandbox_option(object, "Items", 999, 
			"", Globalpreload.Gamba_t)
		"Shield" : 
			set_sandbox_option(object, "Items", 999, 
			"", Globalpreload.Shield_t)
		"Shrink" : 
			set_sandbox_option(object, "Items", 999, 
			"", Globalpreload.Shrink_t)
		"Multi" : 
			set_sandbox_option(object, "Items", 999, 
			"Multi", null)
		"Cleanse" :
			set_sandbox_option(object, "Items", 999, 
			"", Globalpreload.Cleanse_t)
		"Hole" :
			set_sandbox_option(object, "Items", 999, 
			"", Globalpreload.Hole_t)
		"ExplBarrel" : 
			set_sandbox_option(object, "General", 999, 
			"", Globalpreload.ExplBarrel_t)
		"Dumpster" : 
			set_sandbox_option(object, "General", 999, 
			"", Globalpreload.Dumpster_t)
		"Barrel" : 
			set_sandbox_option(object, "General", 999, 
			"", Globalpreload.Barrel_t)
		"Shop" : 
			set_sandbox_option(object, "General", 999, 
			"Shop", null)
		"Items" :
			set_sandbox_option(object, "General", 999, 
			"Items", null)
		"None" : 
			set_sandbox_option(object, "General", 999, 
			"None", null)
		"Deals" :
			set_sandbox_option(object, "General", 999,
			"Deals", null)
		"Hole_Sidewalk" : 
			set_sandbox_option(object, "General", 999, 
			"", Globalpreload.HolePrev_t)
		"None_Street" : 
			set_sandbox_option(object, "Street", 999, 
			"None", null)
		"Hole_Street" : 
			set_sandbox_option(object, "Street", 999, 
			"", Globalpreload.HolePrev_t)
		"PlayerSpeedShop" : 
			set_sandbox_option(object, "Shop", 1, 
			"", Globalpreload.PlayerSpeed_t)
		"GlideBootsShop" : 
			set_sandbox_option(object, "Shop", 1, 
			"", Globalpreload.GlideBoots_t)
		"DashShop" : 
			set_sandbox_option(object, "Shop", 1, 
			"", Globalpreload.Dash_t)
		"expl_BShop" : 
			set_sandbox_option(object, "Shop", 1, 
			"", Globalpreload.expl_B_t)
		"GrappleShop" : 
			set_sandbox_option(object, "Shop", 1, 
			"", Globalpreload.Grapple_t)
		"FollowerShop" : 
			set_sandbox_option(object, "Shop", 1, 
			"", Globalpreload.Follower_t)
		"GambaShop" :
			set_sandbox_option(object, "Shop", 1, 
			"", Globalpreload.Gamba_t)
		"ShieldShop" : 
			set_sandbox_option(object, "Shop", 1, 
			"", Globalpreload.Shield_t)
		"ShrinkShop" : 
			set_sandbox_option(object, "Shop", 1, 
			"", Globalpreload.Shrink_t)
		"SlowShop" : 
			set_sandbox_option(object, "Shop", 1, 
			"", Globalpreload.Slow_t)
		"GrowShop" : 
			set_sandbox_option(object, "Shop", 1, 
			"", Globalpreload.Grow_t)
		"TeleportShop" : 
			set_sandbox_option(object, "Shop", 1, 
			"", Globalpreload.Teleport_t)
		"ItemTeleportShop" : 
			set_sandbox_option(object, "Shop", 1, 
			"", Globalpreload.ItemTeleport_t)
		"CleanseShop" :
			set_sandbox_option(object, "Shop", 1, 
			"", Globalpreload.Cleanse_t)
		"DVDBounceShop" : 
			set_sandbox_option(object, "Shop", 1, 
			"", Globalpreload.DVDBounce_t)
		"HoleShop" : 
			set_sandbox_option(object, "Shop", 1, 
			"", Globalpreload.Hole_t)
		"PlayerSpeedDeal" : 
			set_sandbox_option(object, "Deals", 1, 
			"", Globalpreload.PlayerSpeed_t)
		"GlideBootsDeal" : 
			set_sandbox_option(object, "Deals", 1, 
			"", Globalpreload.GlideBoots_t)
		"DashDeal" : 
			set_sandbox_option(object, "Deals", 1, 
			"", Globalpreload.Dash_t)
		"expl_BDeal" : 
			set_sandbox_option(object, "Deals", 1, 
			"", Globalpreload.expl_B_t)
		"GrappleDeal" : 
			set_sandbox_option(object, "Deals", 1, 
			"", Globalpreload.Grapple_t)
		"FollowerDeal" : 
			set_sandbox_option(object, "Deals", 1, 
			"", Globalpreload.Follower_t)
		"GambaDeal" :
			set_sandbox_option(object, "Deals", 1, 
			"", Globalpreload.Gamba_t)
		"ShieldDeal" : 
			set_sandbox_option(object, "Deals", 1, 
			"", Globalpreload.Shield_t)
		"ShrinkDeal" : 
			set_sandbox_option(object, "Deals", 1, 
			"", Globalpreload.Shrink_t)
		"SlowDeal" : 
			set_sandbox_option(object, "Deals", 1, 
			"", Globalpreload.Slow_t)
		"GrowDeal" : 
			set_sandbox_option(object, "Deals", 1, 
			"", Globalpreload.Grow_t)
		"TeleportDeal" : 
			set_sandbox_option(object, "Deals", 1, 
			"", Globalpreload.Teleport_t)
		"ItemTeleportDeal" : 
			set_sandbox_option(object, "Deals", 1, 
			"", Globalpreload.ItemTeleport_t)
		"CleanseDeal" :
			set_sandbox_option(object, "Deals", 1, 
			"", Globalpreload.Cleanse_t)
		"DVDBounceDeal" : 
			set_sandbox_option(object, "Deals", 1, 
			"", Globalpreload.DVDBounce_t)
		"HoleDeal" : 
			set_sandbox_option(object, "Deals", 1, 
			"", Globalpreload.Hole_t)
		"PlayerSpeedGamba" : 
			set_sandbox_option(object, "Gamba", 1, 
			"", Globalpreload.PlayerSpeed_t)
		"GlideBootsGamba" : 
			set_sandbox_option(object, "Gamba", 1, 
			"", Globalpreload.GlideBoots_t)
		"DashGamba" : 
			set_sandbox_option(object, "Gamba", 1, 
			"", Globalpreload.Dash_t)
		"expl_BGamba" : 
			set_sandbox_option(object, "Gamba", 1, 
			"", Globalpreload.expl_B_t)
		"GrappleGamba" : 
			set_sandbox_option(object, "Gamba", 1, 
			"", Globalpreload.Grapple_t)
		"FollowerGamba" : 
			set_sandbox_option(object, "Gamba", 1, 
			"", Globalpreload.Follower_t)
		"ShrinkGamba" : 
			set_sandbox_option(object, "Gamba", 1, 
			"", Globalpreload.Shrink_t)
		"SlowGamba" : 
			set_sandbox_option(object, "Gamba", 1, 
			"", Globalpreload.Slow_t)
		"GrowGamba" : 
			set_sandbox_option(object, "Gamba", 1, 
			"", Globalpreload.Grow_t)
		"TeleportGamba" : 
			set_sandbox_option(object, "Gamba", 1, 
			"", Globalpreload.Teleport_t)
		"ItemTeleportGamba" : 
			set_sandbox_option(object, "Gamba", 1, 
			"", Globalpreload.ItemTeleport_t)
		"CleanseGamba" :
			set_sandbox_option(object, "Gamba", 1, 
			"", Globalpreload.Cleanse_t)
		"DVDBounceGamba" : 
			set_sandbox_option(object, "Gamba", 1, 
			"", Globalpreload.DVDBounce_t)
		"HoleGamba" : 
			set_sandbox_option(object, "Gamba", 1, 
			"", Globalpreload.Hole_t)
		"PlayerSpeedMulti" : 
			set_sandbox_option(object, "Multi", 999, 
			"", Globalpreload.PlayerSpeed_t)
		"GlideBootsMulti" : 
			set_sandbox_option(object, "Multi", 999, 
			"", Globalpreload.GlideBoots_t)
		"DashMulti" : 
			set_sandbox_option(object, "Multi", 999, 
			"", Globalpreload.Dash_t)
		"expl_BMulti" : 
			set_sandbox_option(object, "Multi", 999, 
			"", Globalpreload.expl_B_t)
		"GrappleMulti" : 
			set_sandbox_option(object, "Multi", 999, 
			"", Globalpreload.Grapple_t)
		"FollowerMulti" : 
			set_sandbox_option(object, "Multi", 999, 
			"", Globalpreload.Follower_t)
		"GambaMulti" :
			set_sandbox_option(object, "Multi", 999, 
			"", Globalpreload.Gamba_t)
		"ShieldMulti" : 
			set_sandbox_option(object, "Multi", 999, 
			"", Globalpreload.Shield_t)
		"ShrinkMulti" : 
			set_sandbox_option(object, "Multi", 999, 
			"", Globalpreload.Shrink_t)
		"SlowMulti" : 
			set_sandbox_option(object, "Multi", 999, 
			"", Globalpreload.Slow_t)
		"GrowMulti" : 
			set_sandbox_option(object, "Multi", 999, 
			"", Globalpreload.Grow_t)
		"TeleportMulti" : 
			set_sandbox_option(object, "Multi", 999, 
			"", Globalpreload.Teleport_t)
		"ItemTeleportMulti" : 
			set_sandbox_option(object, "Multi", 999, 
			"", Globalpreload.ItemTeleport_t)
		"CleanseMulti" :
			set_sandbox_option(object, "Multi", 999, 
			"", Globalpreload.Cleanse_t)
		"DVDBounceMulti" : 
			set_sandbox_option(object, "Multi", 999, 
			"", Globalpreload.DVDBounce_t)
		"HoleMulti" : 
			set_sandbox_option(object, "Multi", 999, 
			"", Globalpreload.Hole_t)
		"CarSpeed" : 
			set_sandbox_option(object, "Misc", 200, 
			"Car Speed (%)", null)
		_: print("object string was not there for sandbox: ", object)

func single_lane_button() -> void:
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	h_slider.custom_minimum_size.x = 500

func no_zero_allowed() -> void:
	h_slider.min_value = 1

func set_sandbox_option(topic : String, type : String, maxint : int, 
labelstr : String, texture : Texture2D) -> void:
	sandbox_type = type
	match labelstr:
		"Multi": set_Multi()
		"Shop": set_label(labelstr)
		"None": set_label(labelstr)
		"Items": set_label(labelstr)
		"Deals": set_label(labelstr)
		"Car Speed (%)": 
			set_label(labelstr)
			single_lane_button()
			no_zero_allowed()
		_: set_texture(texture)
	
	set_slider(
		maxint,
		SettingsDataContainer.get_sandbox_dict(type, topic)
		)
		

func set_texture(texture : Texture2D) -> void:
	sprite_2d.texture = texture
	
func set_Multi() -> void:
	texture_array.resize(3)
	texture_array[0] = Globalpreload.PlayerSpeed_t
	texture_array[1] = Globalpreload.Dash_t
	texture_array[2] = Globalpreload.DVDBounce_t
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
