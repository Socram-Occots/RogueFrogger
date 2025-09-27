extends Area2D

@export var priceItem : Texture2D
@export var productItem : Texture2D
@export var priceItemName : String
@export var productItemName : String
@onready var polygon_2d: Polygon2D = $Polygon2D
@onready var sprite_price_item: Sprite2D = $SpritePriceItem
@onready var pricelabel: Label = $SpritePriceItem/MarginContainer/Label
@onready var sprite_product_item: Sprite2D = $SpriteProductItem
@onready var productlabel: Label = $SpriteProductItem/MarginContainer/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_price_item.texture = priceItem
	sprite_product_item.texture = productItem

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if global_position.y - Global.player_pos_y > Global.despawn_lower:
		queue_free()

func _on_body_entered(body):
	var metalist : PackedStringArray = body.get_meta_list()
	for i in ["Player", "Follower"]:
		if i in metalist:
			var can_they_purchase : bool = false
			match priceItemName:
				"PlayerSpeed":pass
				"GlideBoots":pass
				"Dash":pass
				"expl_B":pass
				"GrappleRope":pass
				"Follower":pass
				"Shrink":pass
				"Gamba":pass
				"Slow":pass
				"Grow":pass
				"LongTeleport":pass
				"ShortTeleport":pass
				"DVDBounce":pass
