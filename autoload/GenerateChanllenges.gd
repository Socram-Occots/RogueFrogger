extends Node

var copied_sandbox_dict : Dictionary = {}
var chal_result_dict : Dictionary = {}
var chal_result_high_score_dict : Dictionary = {}
const sdxdict : String = "SandboxDict"
const StartingItems : String = "StartingItems"
const gen : String = "General"
const items : String = "Items"
const multi : String = "Multi"
const gamba : String = "Gamba"
const shop : String = "Shop"
const misc : String = "Misc"
const deals : String = "Deals"
const Street : String = "Street"
# general
const shopGen : String = "Shop"
const dealGen : String = "Deals"
const explBarrel : String = "ExplBarrel"
const dump : String = "Dumpster"
const barrel : String = "Barrel"
const none : String = "None"
const holeS : String = "Hole_Sidewalk"
const itemsGen : String = "Items"
# Street
const street_none : String = "None_Street"
const street_hole : String = "Hole_Street"
# Items
const speed : String = "PlayerSpeed"
const glide : String = "GlideBoots"
const dash : String = "Dash"
const expl_B : String = "expl_B"
const grapple : String = "Grapple"
const follower : String = "Follower"
const gambaItem : String = "Gamba"
const shield : String = "Shield"
const shrink : String = "Shrink"
const multiItem : String = "Multi"
const cleanse : String = "Cleanse"
const hole : String = "Hole"
# Multi
const PlayerSpeedMulti : String = "PlayerSpeedMulti"
const GlideBootsMulti : String = "GlideBootsMulti"
const DashMulti : String = "DashMulti"
const expl_BMulti : String = "expl_BMulti"
const GrappleMulti : String = "GrappleMulti"
const FollowerMulti : String = "FollowerMulti"
const GambaMulti : String = "GambaMulti"
const ShieldMulti : String = "ShieldMulti"
const ShrinkMulti : String = "ShrinkMulti"
const SlowMulti : String = "SlowMulti"
const GrowMulti : String = "GrowMulti"
const TeleportMulti : String = "TeleportMulti"
const ItemTeleportMulti : String = "ItemTeleportMulti"
const CleanseMulti : String = "CleanseMulti"
const DVDBounceMulti : String = "DVDBounceMulti"
const HoleMulti : String = "HoleMulti"
# Gamba
const PlayerSpeedGamba : String = "PlayerSpeedGamba"
const GlideBootsGamba : String = "GlideBootsGamba"
const DashGamba : String = "DashGamba"
const expl_BGamba : String = "expl_BGamba"
const GrappleGamba : String = "GrappleGamba"
const FollowerGamba : String = "FollowerGamba"
const ShrinkGamba : String = "ShrinkGamba"
const SlowGamba : String = "SlowGamba"
const GrowGamba : String = "GrowGamba"
const TeleportGamba : String = "TeleportGamba"
const ItemTeleportGamba : String = "ItemTeleportGamba"
const CleanseGamba : String = "CleanseGamba"
const DVDBounceGamba : String = "DVDBounceGamba"
const HoleGamba : String = "HoleGamba"
# Shop
const PlayerSpeedShop : String = "PlayerSpeedShop"
const GlideBootsShop : String = "GlideBootsShop"
const DashShop : String = "DashShop"
const expl_BShop : String = "expl_BShop"
const GrappleShop : String = "GrappleShop"
const FollowerShop : String = "FollowerShop"
const GambaShop : String = "GambaShop"
const ShieldShop : String = "ShieldShop"
const ShrinkShop : String = "ShrinkShop"
const SlowShop : String = "SlowShop"
const GrowShop : String = "GrowShop"
const TeleportShop : String = "TeleportShop"
const ItemTeleportShop : String = "ItemTeleportShop"
const CleanseShop : String = "CleanseShop"
const DVDBounceShop : String = "DVDBounceShop"
const HoleShop : String = "HoleShop"
# Deal
const PlayerSpeedDeal : String = "PlayerSpeedDeal"
const GlideBootsDeal : String = "GlideBootsDeal"
const DashDeal : String = "DashDeal"
const expl_BDeal : String = "expl_BDeal"
const GrappleDeal : String = "GrappleDeal"
const FollowerDeal : String = "FollowerDeal"
const GambaDeal : String = "GambaDeal"
const ShieldDeal : String = "ShieldDeal"
const ShrinkDeal : String = "ShrinkDeal"
const SlowDeal : String = "SlowDeal"
const GrowDeal : String = "GrowDeal"
const TeleportDeal : String = "TeleportDeal"
const ItemTeleportDeal : String = "ItemTeleportDeal"
const CleanseDeal : String = "CleanseDeal"
const DVDBounceDeal : String = "DVDBounceDeal"
const HoleDeal : String = "HoleDeal"
# Misc
const CarSpeed : String = "CarSpeed"

const Desc : String = "Desc"

func import_dict(dict : Dictionary) -> void:
	copied_sandbox_dict = dict.duplicate(true)

func generate_challenges(dict : Dictionary) -> Dictionary:
	import_dict(dict)
	create_callenge("Glide & Dash Practice")
	create_callenge("Oops! All Dumpsters!")
	create_callenge("Swinging Through the Jungle")
	create_callenge("The Curse of Crosser")
	create_callenge("Speed Demon")
	create_callenge("The Demoman")
	create_callenge("The Art of the Deal")
	create_callenge("Trypophobia")
	create_callenge("Enough! Just you and me…")
	create_callenge("Overcoming Trypophobia")
	create_callenge("Little Big Crosser")
	create_callenge("Hardcore")
	return chal_result_dict

func create_callenge(nameStr : String) -> void:
	chal_result_dict[nameStr] = {}
	chal_result_dict[nameStr]["SandboxDict"] = copied_sandbox_dict.duplicate(true)
	chal_result_dict[nameStr][Desc] = ""
	chal_result_dict[nameStr][StartingItems] = {}
	match nameStr:
		"Speed Demon":
			for i in chal_result_dict[nameStr][sdxdict][gen].keys():
				chal_result_dict[nameStr][sdxdict][gen][i] = 0
				
			chal_result_dict[nameStr][sdxdict][gen][itemsGen] = 1
			
			for i in chal_result_dict[nameStr][sdxdict][items].keys():
				chal_result_dict[nameStr][sdxdict][items][i] = 0
				
			chal_result_dict[nameStr][sdxdict][items][speed] = 15
			chal_result_dict[nameStr][sdxdict][items][follower] = 1
			chal_result_dict[nameStr][sdxdict][misc][CarSpeed] = 200
			chal_result_dict[nameStr][StartingItems][speed] = 50
			chal_result_dict[nameStr][Desc] = \
			"Gotta go fast!
			Disclamer: This challenge will likely lead to the game breaking.
			If this happens, you will have to restart the run or return to the main menu."
			
		"Swinging Through the Jungle":
			chal_result_dict[nameStr][sdxdict][gen][shopGen] = 0
			chal_result_dict[nameStr][sdxdict][gen][dealGen] = 0
			chal_result_dict[nameStr][sdxdict][gen][explBarrel] = 0
			chal_result_dict[nameStr][sdxdict][gen][dump] = 50
			chal_result_dict[nameStr][sdxdict][gen][none] = 400
			chal_result_dict[nameStr][sdxdict][gen][itemsGen] = 200
			
			for i in chal_result_dict[nameStr][sdxdict][items].keys():
				chal_result_dict[nameStr][sdxdict][items][i] = 0
				
			chal_result_dict[nameStr][sdxdict][items][grapple] = 15
			chal_result_dict[nameStr][sdxdict][items][follower] = 1
			chal_result_dict[nameStr][StartingItems][grapple] = 1
			chal_result_dict[nameStr][Desc] = "How far can you get swinging through traffic?"
			
		"The Curse of Crosser":
			chal_result_dict[nameStr][sdxdict][gen][shopGen] = 0
			chal_result_dict[nameStr][sdxdict][gen][itemsGen] = 500
			chal_result_dict[nameStr][sdxdict][gen][none] = 50
			
			for i in chal_result_dict[nameStr][sdxdict][items].keys():
				chal_result_dict[nameStr][sdxdict][items][i] = 0
			for i in chal_result_dict[nameStr][sdxdict][multi].keys():
				chal_result_dict[nameStr][sdxdict][multi][i] = 0
			for i in chal_result_dict[nameStr][sdxdict][gamba].keys():
				chal_result_dict[nameStr][sdxdict][gamba][i] = 0
			for i in chal_result_dict[nameStr][sdxdict][deals].keys():
				chal_result_dict[nameStr][sdxdict][deals][i] = 0
			
			chal_result_dict[nameStr][sdxdict][items][multiItem] = 1
			chal_result_dict[nameStr][sdxdict][multi][GambaMulti] = 1
			chal_result_dict[nameStr][sdxdict][multi][SlowMulti] = 1
			chal_result_dict[nameStr][sdxdict][multi][GrowMulti] = 1
			chal_result_dict[nameStr][sdxdict][multi][TeleportMulti] = 1
			chal_result_dict[nameStr][sdxdict][multi][ItemTeleportMulti] = 1
			chal_result_dict[nameStr][sdxdict][multi][DVDBounceMulti] = 1
			chal_result_dict[nameStr][sdxdict][gamba][SlowGamba] = 1
			chal_result_dict[nameStr][sdxdict][gamba][GrowGamba] = 1
			chal_result_dict[nameStr][sdxdict][gamba][TeleportGamba] = 1
			chal_result_dict[nameStr][sdxdict][gamba][ItemTeleportGamba] = 1
			chal_result_dict[nameStr][sdxdict][gamba][DVDBounceShop] = 1
			chal_result_dict[nameStr][sdxdict][deals][FollowerDeal] = 1
			chal_result_dict[nameStr][sdxdict][deals][GambaDeal] = 1
			chal_result_dict[nameStr][sdxdict][deals][SlowDeal] = 1
			chal_result_dict[nameStr][sdxdict][deals][GrowDeal] = 1
			chal_result_dict[nameStr][sdxdict][deals][TeleportDeal] = 1
			chal_result_dict[nameStr][sdxdict][deals][ItemTeleportDeal] = 1
			chal_result_dict[nameStr][sdxdict][deals][DVDBounceDeal] = 1
			chal_result_dict[nameStr][StartingItems][SlowMulti] = 5
			chal_result_dict[nameStr][StartingItems][GrowMulti] = 20
			chal_result_dict[nameStr][StartingItems][TeleportMulti] = 50
			chal_result_dict[nameStr][StartingItems][DVDBounceMulti] = 20
			chal_result_dict[nameStr][Desc] = "Curses! This challenge sure is cursed."
			
		"The Art of the Deal":
			chal_result_dict[nameStr][sdxdict][gen][shopGen] = 50
			chal_result_dict[nameStr][sdxdict][gen][dealGen] = 100
			
			for i in chal_result_dict[nameStr][sdxdict][items].keys():
				chal_result_dict[nameStr][sdxdict][items][i] = 0
			for i in chal_result_dict[nameStr][sdxdict][multi].keys():
				chal_result_dict[nameStr][sdxdict][multi][i] = 0
			for i in chal_result_dict[nameStr][sdxdict][gamba].keys():
				chal_result_dict[nameStr][sdxdict][gamba][i] = 0
				
			chal_result_dict[nameStr][sdxdict][items][multiItem] = 1
			chal_result_dict[nameStr][sdxdict][items][gambaItem] = 1
			chal_result_dict[nameStr][sdxdict][multi][GambaMulti] = 1
			chal_result_dict[nameStr][sdxdict][gamba][SlowGamba] = 1
			chal_result_dict[nameStr][sdxdict][gamba][GrowGamba] = 1
			chal_result_dict[nameStr][sdxdict][gamba][TeleportGamba] = 1
			chal_result_dict[nameStr][sdxdict][gamba][ItemTeleportGamba] = 1
			chal_result_dict[nameStr][sdxdict][gamba][DVDBounceShop] = 1
			chal_result_dict[nameStr][StartingItems][SlowMulti] = 1
			chal_result_dict[nameStr][StartingItems][GrowMulti] = 1
			chal_result_dict[nameStr][StartingItems][TeleportMulti] = 1
			chal_result_dict[nameStr][StartingItems][ItemTeleportMulti] = 1
			chal_result_dict[nameStr][StartingItems][DVDBounceMulti] = 1
			chal_result_dict[nameStr][Desc] = "Can you bargain your way out of this run?"
		
		"The Demoman":
			chal_result_dict[nameStr][sdxdict][gen][barrel] = 0
			chal_result_dict[nameStr][sdxdict][gen][explBarrel] = 200
			chal_result_dict[nameStr][sdxdict][gen][itemsGen] = 200
			chal_result_dict[nameStr][sdxdict][gen][none] = 400
			
			for i in chal_result_dict[nameStr][sdxdict][items].keys():
				chal_result_dict[nameStr][sdxdict][items][i] = 0
			for i in chal_result_dict[nameStr][sdxdict][deals].keys():
				chal_result_dict[nameStr][sdxdict][deals][i] = 0
			for i in chal_result_dict[nameStr][sdxdict][shop].keys():
				chal_result_dict[nameStr][sdxdict][shop][i] = 0
			for i in chal_result_dict[nameStr][sdxdict][gamba].keys():
				chal_result_dict[nameStr][sdxdict][gamba][i] = 0
			
			chal_result_dict[nameStr][sdxdict][items][expl_B] = 15
			chal_result_dict[nameStr][sdxdict][items][follower] = 1
			chal_result_dict[nameStr][sdxdict][items][cleanse] = 1
			chal_result_dict[nameStr][sdxdict][deals][expl_BDeal] = 1
			chal_result_dict[nameStr][sdxdict][deals][FollowerDeal] = 1
			chal_result_dict[nameStr][sdxdict][deals][CleanseDeal] = 1
			chal_result_dict[nameStr][sdxdict][deals][GambaDeal] = 1
			chal_result_dict[nameStr][sdxdict][deals][SlowDeal] = 1
			chal_result_dict[nameStr][sdxdict][deals][GrowDeal] = 1
			chal_result_dict[nameStr][sdxdict][deals][TeleportDeal] = 1
			chal_result_dict[nameStr][sdxdict][deals][ItemTeleportDeal] = 1
			chal_result_dict[nameStr][sdxdict][deals][DVDBounceDeal] = 1
			chal_result_dict[nameStr][sdxdict][shop][expl_BShop] = 1
			chal_result_dict[nameStr][sdxdict][shop][FollowerShop] = 1
			chal_result_dict[nameStr][sdxdict][shop][CleanseShop] = 1
			chal_result_dict[nameStr][sdxdict][shop][GambaShop] = 1
			chal_result_dict[nameStr][sdxdict][shop][SlowShop] = 1
			chal_result_dict[nameStr][sdxdict][shop][GrowShop] = 1
			chal_result_dict[nameStr][sdxdict][shop][TeleportShop] = 1
			chal_result_dict[nameStr][sdxdict][shop][ItemTeleportShop] = 1
			chal_result_dict[nameStr][sdxdict][shop][DVDBounceShop] = 1
			chal_result_dict[nameStr][sdxdict][gamba][expl_BGamba] = 1
			chal_result_dict[nameStr][sdxdict][gamba][FollowerGamba] = 1
			chal_result_dict[nameStr][sdxdict][gamba][CleanseGamba] = 1
			chal_result_dict[nameStr][sdxdict][gamba][SlowGamba] = 1
			chal_result_dict[nameStr][sdxdict][gamba][GrowGamba] = 1
			chal_result_dict[nameStr][sdxdict][gamba][TeleportGamba] = 1
			chal_result_dict[nameStr][sdxdict][gamba][ItemTeleportGamba] = 1
			chal_result_dict[nameStr][sdxdict][gamba][DVDBounceShop] = 1
			chal_result_dict[nameStr][Desc] = "What makes me a good Demoman?"
		"Trypophobia":
			for i in chal_result_dict[nameStr][sdxdict][gen].keys():
				chal_result_dict[nameStr][sdxdict][gen][i] = 0
			for i in chal_result_dict[nameStr][sdxdict][Street].keys():
				chal_result_dict[nameStr][sdxdict][Street][i] = 0
			
			chal_result_dict[nameStr][sdxdict][gen][holeS] = 1
			chal_result_dict[nameStr][sdxdict][Street][street_hole] = 1
			chal_result_dict[nameStr][Desc] = "A very holesome challenge."
		"Overcoming Trypophobia":
			for i in chal_result_dict[nameStr][sdxdict][gen].keys():
				chal_result_dict[nameStr][sdxdict][gen][i] = 0
			for i in chal_result_dict[nameStr][sdxdict][Street].keys():
				chal_result_dict[nameStr][sdxdict][Street][i] = 0
				
			chal_result_dict[nameStr][sdxdict][gen][itemsGen] = 1
			chal_result_dict[nameStr][sdxdict][gen][holeS] = 20
			chal_result_dict[nameStr][sdxdict][gen][explBarrel] = 1
			chal_result_dict[nameStr][sdxdict][Street][street_hole] = 1
			chal_result_dict[nameStr][Desc] = "An even more holesome challenge."
		"Oops! All Dumpsters!":
			for i in chal_result_dict[nameStr][sdxdict][gen].keys():
				chal_result_dict[nameStr][sdxdict][gen][i] = 0
			for i in chal_result_dict[nameStr][sdxdict][Street].keys():
				chal_result_dict[nameStr][sdxdict][Street][i] = 0
			
			chal_result_dict[nameStr][sdxdict][gen][dump] = 1
			chal_result_dict[nameStr][sdxdict][misc][CarSpeed] = 75
			chal_result_dict[nameStr][StartingItems][speed] = 10
			chal_result_dict[nameStr][StartingItems][shrink] = 50
			chal_result_dict[nameStr][Desc] = "What a dumpster fire..."
		"Enough! Just you and me…":
			for i in chal_result_dict[nameStr][sdxdict][gen].keys():
				chal_result_dict[nameStr][sdxdict][gen][i] = 0
			for i in chal_result_dict[nameStr][sdxdict][Street].keys():
				chal_result_dict[nameStr][sdxdict][Street][i] = 0
			chal_result_dict[nameStr][Desc] = "Just you and the cars."
		"Glide & Dash Practice":
			chal_result_dict[nameStr][sdxdict][gen][shopGen] = 0
			chal_result_dict[nameStr][sdxdict][gen][dealGen] = 0
			chal_result_dict[nameStr][sdxdict][gen][explBarrel] = 0
			chal_result_dict[nameStr][sdxdict][gen][itemsGen] = 200
			
			for i in chal_result_dict[nameStr][sdxdict][items].keys():
				chal_result_dict[nameStr][sdxdict][items][i] = 0
			
			chal_result_dict[nameStr][sdxdict][items][dash] = 15
			chal_result_dict[nameStr][sdxdict][items][glide] = 15
			chal_result_dict[nameStr][sdxdict][items][follower] = 1
			chal_result_dict[nameStr][StartingItems][dash] = 1
			chal_result_dict[nameStr][StartingItems][glide] = 1
			chal_result_dict[nameStr][Desc] = \
			"Did you know you can glide then dash at the same time?
			Test out the interaction between these two items here.
			Mastering this can vasty improve your scores."
		"Hardcore":
			chal_result_dict[nameStr][sdxdict][gen][shopGen] = 5
			chal_result_dict[nameStr][sdxdict][gen][dealGen] = 5
			chal_result_dict[nameStr][sdxdict][gen][explBarrel] = 5
			chal_result_dict[nameStr][sdxdict][gen][itemsGen] = 20
			chal_result_dict[nameStr][Desc] = \
			"There are way less resources to help you on your journey."
		"Little Big Crosser":
			chal_result_dict[nameStr][sdxdict][gen][shopGen] = 0
			chal_result_dict[nameStr][sdxdict][gen][deals] = 0
			chal_result_dict[nameStr][sdxdict][gen][itemsGen] = 500
			
			for i in chal_result_dict[nameStr][sdxdict][items].keys():
				chal_result_dict[nameStr][sdxdict][items][i] = 0
			for i in chal_result_dict[nameStr][sdxdict][gamba].keys():
				chal_result_dict[nameStr][sdxdict][gamba][i] = 0
			
			chal_result_dict[nameStr][sdxdict][items][gambaItem] = 20
			chal_result_dict[nameStr][sdxdict][items][follower] = 1
			chal_result_dict[nameStr][sdxdict][gamba][ShrinkGamba] = 1
			chal_result_dict[nameStr][sdxdict][gamba][GrowGamba] = 1
			chal_result_dict[nameStr][sdxdict][gamba][FollowerGamba] = 1
			chal_result_dict[nameStr][Desc] = \
			"Is it a small crosser in a big world, or a big crosser in a small world?"
