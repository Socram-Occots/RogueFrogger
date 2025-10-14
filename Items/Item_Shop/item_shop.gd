extends Area2D

@export var priceItem : Texture2D
@export var productItem : Texture2D
@export var priceItemName : String
@export var productItemName : String
@export var pricenum : int
@export var productnum : int
@onready var polygon_2d: Polygon2D = $Polygon2D
@onready var sprite_price_item: Sprite2D = $SpritePriceItem
@onready var pricelabel: Label = $SpritePriceItem/MarginContainer/Label
@onready var sprite_product_item: Sprite2D = $SpriteProductItem
@onready var productlabel: Label = $SpriteProductItem/MarginContainer/Label
@onready var not_entered : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_price_item.texture = priceItem
	sprite_product_item.texture = productItem
	polygon_2d.color = Color(0, 0, 0)
	pricelabel.text = str(pricenum) + "x"
	if productItemName == "Shield":
		productlabel.text = "1x"
	else:
		productlabel.text = str(productnum) + "x"
# Called every frame. 'delta' is the elapsed time since the previous frame.

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass

func _on_body_entered(body):
	var metalist : PackedStringArray = body.get_meta_list()
	if not_entered:
		for i in ["Player"]:
			if i in metalist:
				var bought : bool = false
				not_entered = false
				match priceItemName:
					"PlayerSpeedShop": 
						if pricenum <= Global.player_speed_mod:
							Global.inc_PlayerSpeed(-1*pricenum)
							bought = true
					"GlideBootsShop":
						if pricenum <= Global.glide_mod:
							Global.inc_GlideBoots(-1*pricenum)
							bought = true
					"DashShop":
						if pricenum <= Global.dash_mod:
							Global.inc_Dash(-1*pricenum)
							bought = true
					"expl_BShop":
						if pricenum <= Global.expl_B_mod:
							Global.inc_expl_B(-1*pricenum)
							bought = true
					"GrappleRopeShop":
						if pricenum <= Global.grapple_mod:
							Global.inc_GrappleRope(-1*pricenum)
							bought = true
					"FollowerShop":
						if pricenum <= Global.follower_mod - Global.follower_mod_base:
							Global.inc_Follower(-1*pricenum)
							bought = true
					"ShrinkShop":
						if pricenum <= Global.shrink_mod:
							Global.inc_Shrink(-1*pricenum)
							bought = true
					"SlowShop":
						if pricenum <= Global.playerslow_mod - Global.playerslow_mod_base:
							Global.inc_PlayerSlow(-1*pricenum)
							bought = true
					"GrowShop":
						if pricenum <= Global.grow_mod:
							Global.inc_Grow(-1*pricenum)
							bought = true
					"LongTeleportShop":
						if pricenum <= Global.longtele_mod:
							Global.inc_LongTele(-1*pricenum)
							bought = true
					"ShortTeleportShop":
						if pricenum <= Global.shorttele_mod:
							Global.inc_ShortTele(-1*pricenum)
							bought = true
					"DVDBounceShop":
						if pricenum <= Global.dvd_mod:
							Global.inc_DVD(-1*pricenum)
							bought = true
					_: print("Price Item not found: ", priceItemName)
				if bought:
					polygon_2d.color = Color(0, 225, 0)
					match productItemName:
						"PlayerSpeedShop": Global.inc_PlayerSpeed(productnum)
						"GlideBootsShop": Global.inc_GlideBoots(productnum)
						"DashShop": Global.inc_Dash(productnum)
						"expl_BShop": Global.inc_expl_B(productnum)
						"GrappleRopeShop": Global.inc_GrappleRope(productnum)
						"FollowerShop": Global.inc_Follower(productnum)
						"ShrinkShop": Global.inc_Shrink(productnum)
						"GambaShop": Global.inc_Gamba(productnum)
						"CleanseShop" : Global.cleanse_curse(productnum)
						"ShieldShop": Global.follower_array[0].shield_up = true
						_: print("Product item was not found: ", productItemName)
				else:
					polygon_2d.color = Color(225, 0, 0)

func _on_body_exited(body: Node2D) -> void:
	var metalist : PackedStringArray = body.get_meta_list()
	for i in ["Player"]:
		if i in metalist:
			not_entered = true
			polygon_2d.color = Color(0, 0, 0)
