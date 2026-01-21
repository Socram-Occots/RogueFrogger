extends Item

@export var dealItem : Texture2D
@export var dealCurse : Texture2D
@export var dealItemName : String
@export var dealCurseName : String
@export var dealnum : int
@export var cursenum : int
@onready var polygon_2d: Polygon2D = $Node2D/Polygon2D
@onready var sprite_deal_item: Sprite2D = $Node2D/ItemDeal
@onready var deallabel: Label = $Node2D/ItemDeal/MarginContainer/Label
@onready var sprite_product_item: Sprite2D = $Node2D/CurseDeal
@onready var productlabel: Label = $Node2D/CurseDeal/MarginContainer/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_meta("Item", false)
	set_meta("Deal", false)
	sprite_deal_item.texture = dealItem
	sprite_product_item.texture = dealCurse
	polygon_2d.color = Color(0, 0, 0)
	productlabel.text = str(cursenum) + "x"
	if dealItemName == "ShieldDeal":
		deallabel.text = "1x"
	else:
		deallabel.text = str(dealnum) + "x"

func _on_body_entered(body):
	var metalist : PackedStringArray = body.get_meta_list()
	for i in ["Player"]:
		if i in metalist:
			match dealItemName:
				"PlayerSpeedDeal": Global.inc_PlayerSpeed(dealnum)
				"GlideBootsDeal": Global.inc_GlideBoots(dealnum)
				"DashDeal": Global.inc_Dash(dealnum)
				"expl_BDeal": Global.inc_expl_B(dealnum)
				"GrappleDeal": Global.inc_GrappleRope(dealnum)
				"FollowerDeal": Global.inc_Follower(dealnum)
				"ShrinkDeal": Global.inc_Shrink(dealnum)
				"HoleDeal": Global.inc_Hole(dealnum)
				"GambaDeal": Global.inc_Gamba(dealnum)
				"ShieldDeal": Global.follower_array[0].shield_up = true
				"CleanseDeal" : Global.cleanse_curse(cursenum)
				_: print("Deal Item not found: ", dealItemName)
			match dealCurseName:
				"SlowDeal": Global.inc_PlayerSlow(cursenum)
				"GrowDeal": Global.inc_Grow(cursenum)
				"TeleportDeal": Global.inc_Tele(cursenum)
				"ItemTeleportDeal": Global.inc_ItemTele(cursenum)
				"DVDBounceDeal": Global.inc_DVD(cursenum)
				_: print("Deal Curse was not found: ", dealCurseName)
			
			queue_free()
