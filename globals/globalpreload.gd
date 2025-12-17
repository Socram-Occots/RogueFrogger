extends Node

# importing
const CAR : Resource = preload("res://Car/car.tscn")
const ITEM : Resource = preload("res://Items/items.tscn")
const BARREL : Resource = preload("res://Barrel/barrel.tscn")
const TILES : Resource = preload("res://tilemaps/tilemaps.tscn")
const CROSSER : Resource = preload("res://Crosser/crosser.tscn")
const DUMP : Resource = preload("res://Dumpster/dumpster.tscn")
const BORDER : Resource = preload("res://Level/border.tscn")
const LINE : Resource = preload("res://lineofdeath/lineofdeath.tscn")
const POP : Resource = preload("res://menus/GameUI/popups.tscn")
const EXPLBARREL : Resource = preload("res://Barrel/exploding_barrel.tscn")
const ITEMLABELS : Resource = preload("res://Items/itemlabels.tscn")
const DEFEAT : Resource = preload("res://menus/GameUI/game_over.tscn")
const PAUSE : Resource = preload("res://menus/GameUI/pause_panel.tscn")
const CHECKERDLINE : Resource  = preload("res://finishline/finish_line.tscn")
const GAMBAPICKER : Resource  = preload("res://Items/Gamba/Gamba.tscn")
const FOLLOWERSCRIPT : Script = preload("res://Follower/followerLogic.gd")
const DVDBOUNCE : Resource = preload("res://DVD_bounce/DVD_bounce.tscn")
const SHOP : Resource = preload("res://Items/Item_Shop/ItemShop.tscn")
const GRAPPLE : Resource = preload("res://Grapplerope/grapplerope.tscn")
const TELE : Resource = preload("res://Items/Teleport/teleportoutline.tscn")
const HOLE : Resource = preload("res://Hole/hole.tscn")
const ITEMGRAPPLESCRIPT : Script = preload("res://Grapplerope/itemgrapplelogic.gd")
const TOOLTIPS : ItemToolTipDict = preload("res://menus/itemtooltipdescriptions.tres")
const TELEPORTLINE : Resource = preload("res://Items/Teleport/teleportline.tscn")
const ITEMTELE : Resource = preload("res://Items/Teleport/itemteleportoutline.tscn")
#var UICONTROLS : Resource = preload("res://menus/GameUI/UI_Controls.tscn")

#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("dash"):
		#
		#CAR_INST.queue_free()
		#BARREL_INST.queue_free()
		#TILES_INST.queue_free()
		#DUMP_INST.queue_free()
		#BORDER_INST.queue_free()
		#EXPLBARREL_INST.queue_free()
		#POP_INST.queue_free()
		#DVD_INST.queue_free()
		#SHOP_INST.queue_free()
		#DEATHLINE_INST.queue_free()
		#
		#DVDarea.queue_free()
		#DVDnode.queue_free()
		#
		#iconlabels.queue_free()
		#playerspeedicon.queue_free()
		#glideicon.queue_free()
		#dashicon.queue_free()
		#expl_B_icon.queue_free()
		#grapple_icon.queue_free()
		#follower_icon.queue_free()
		#shrink_icon.queue_free()
		#slow_icon.queue_free()
		#grow_icon.queue_free()
		#longtele_icon.queue_free()
		#shorttele_icon.queue_free()
		#cleanse_icon.queue_free()
		#dvdbounce_icon.queue_free()
		#
		#items_instantiate.queue_free()
		#
		#follower_basic.queue_free()
		#grapplehook.queue_free()
		#tele.queue_free()
		#
		#DEFEAT_INST.queue_free()
		#PAUSE_INST.queue_free()
		#
		#await get_tree().process_frame
		#print_orphan_nodes()

var CAR_INST : Node2D = CAR.instantiate()
var BARREL_INST : StaticBody2D = BARREL.instantiate()
var TILES_INST : Node2D = TILES.instantiate()
var DUMP_INST : StaticBody2D = DUMP.instantiate()
var BORDER_INST : Node2D = BORDER.instantiate()
var EXPLBARREL_INST : RigidBody2D = EXPLBARREL.instantiate()
var POP_INST : Control = POP.instantiate()
var DVD_INST : Node2D = DVDBOUNCE.instantiate()
var SHOP_INST : Area2D = SHOP.instantiate()
var DEATHLINE_INST : Area2D = LINE.instantiate()
var HOLE_INST : Area2D = HOLE.instantiate()

# DVD Bounce
var DVDarea : Node2D = DVDBOUNCE.instantiate()
var DVDnode : RigidBody2D = DVDarea.get_node("DVDnode")

# icons
var iconlabels : Node = ITEMLABELS.instantiate()
var playerspeedicon : VBoxContainer = iconlabels.get_node("PlayerSpeedVbox")
var glideicon : VBoxContainer = iconlabels.get_node("GlideVbox")
var dashicon : VBoxContainer = iconlabels.get_node("DashVbox")
var expl_B_icon : VBoxContainer = iconlabels.get_node("expl_B_Vbox")
var grapple_icon : VBoxContainer = iconlabels.get_node("GrappleVbox")
var follower_icon : VBoxContainer = iconlabels.get_node("FollowerVbox")
var shrink_icon : VBoxContainer = iconlabels.get_node("ShrinkVbox")
var slow_icon : VBoxContainer = iconlabels.get_node("SlowVbox")
var grow_icon : VBoxContainer = iconlabels.get_node("GrowVbox")
var tele_icon : VBoxContainer = iconlabels.get_node("TeleportVbox")
var itemtele_icon : VBoxContainer = iconlabels.get_node("ItemTeleportVbox")
var cleanse_icon : VBoxContainer = iconlabels.get_node("CleanseVbox")
var dvdbounce_icon : VBoxContainer = iconlabels.get_node("DVDBounceVbox")
var hole_icon : VBoxContainer = iconlabels.get_node("HoleVbox")

# glowicons
var items_instantiate : Node = ITEM.instantiate()
var playerspeedglowicon : Texture2D = items_instantiate.get_node("PlayerSpeed/Sprite2D").texture
var glideglowicon : Texture2D = items_instantiate.get_node("GlideBoots/Sprite2D").texture
var dashglowicon : Texture2D = items_instantiate.get_node("Dash/Sprite2D").texture
var expl_B_glowicon : Texture2D = items_instantiate.get_node("expl_B/Sprite2D").texture
var grapple_glowicon : Texture2D = items_instantiate.get_node("Grapple/Sprite2D").texture
var follower_glowicon : Texture2D = items_instantiate.get_node("Follower/Sprite2D").texture
var shrink_glowicon : Texture2D = items_instantiate.get_node("Shrink/Sprite2D").texture
var gamba_glowicon : Texture2D = items_instantiate.get_node("Gamba/Sprite2D").texture
var shield_glowicon : Texture2D = items_instantiate.get_node("Shield/Sprite2D").texture
var slow_glowicon : Texture2D = items_instantiate.get_node("Slow/Sprite2D").texture
var grow_glowicon : Texture2D = items_instantiate.get_node("Grow/Sprite2D").texture
var tele_glowicon : Texture2D = items_instantiate.get_node("Teleport/Sprite2D").texture
var itemtele_glowicon : Texture2D = items_instantiate.get_node("ItemTeleport/Sprite2D").texture
var cleanse_glowicon : Texture2D = items_instantiate.get_node("Cleanse/Sprite2D").texture
var dvdbounce_glowicon : Texture2D = items_instantiate.get_node("DVDBounce/Sprite2D").texture
var hole_glowicon : Texture2D = items_instantiate.get_node("Hole/Sprite2D").texture

# Crosser
var follower_basic : RigidBody2D = CROSSER.instantiate()
var grapplehook : Line2D = GRAPPLE.instantiate()
var itemgrapplehook : Line2D = grapplehook.duplicate()
var tele : Area2D = TELE.instantiate()
var itemtele : Area2D = ITEMTELE.instantiate()
var delete_array : Array = []

# game
var DEFEAT_INST : Control = DEFEAT.instantiate()
var PAUSE_INST : Control = PAUSE.instantiate()

#teleport
var teleportline : Line2D = TELEPORTLINE.instantiate()

# UI
#var uicontrols : VBoxContainer = UICONTROLS.instantiate()

func delete_stray_nodes() -> void:
	for i in delete_array:
		if is_instance_valid(i):
			i.queue_free()
	delete_array.clear()

func _ready() -> void:
	itemgrapplehook.set_script(ITEMGRAPPLESCRIPT)
	itemgrapplehook.get_node("grappleHead/CollisionShape2D").set_deferred("disabled", true)
