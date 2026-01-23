class_name DefaultSettingsResource
extends Resource

# settings
const default_window_mode_index : int = 0
const default_resolution_index : int = 7
const default_aspect_selected : int = 0
const default_master_volume : float = 0.5
const default_music_volume : float = 0.5
const default_sfx_volume : float = 0.5
# game data
const default_high_score : int = 0
const default_speedrun_dict : Dictionary = {
	"speedrun_100":0,
	"speedrun_250":0,
	"speedrun_500":0,
	"speedrun_750":0,
	"speedrun_1000":0
}
# sandbox data
const default_general_sandbox_dict : Dictionary = {
	"ExplBarrel":50,
	"Dumpster":50,
	"Barrel":200,
	"Shop":10,
	"Items":75,
	"None":800,
	"Hole_Sidewalk":20,
	"Deals":10
}

const default_street_sandbox_dict : Dictionary = {
	"None_Street":800,
	"Hole_Street":25
}

const default_items_sandbox_dict : Dictionary = {
	"PlayerSpeed":500,
	"GlideBoots":500,
	"Dash":500,
	"expl_B":500,
	"Grapple":500,
	"Follower":50,
	"Gamba":500,
	"Shield":10,
	"Shrink":500,
	"Multi":800,
	"Cleanse":100,
	"Hole":500
}
const default_multi_sandbox_dict : Dictionary = {
	"PlayerSpeedMulti":500,
	"GlideBootsMulti":500,
	"DashMulti":500,
	"expl_BMulti":500,
	"GrappleMulti":500,
	"FollowerMulti":50,
	"GambaMulti":500,
	"ShieldMulti":10,
	"ShrinkMulti":500,
	"SlowMulti":100,
	"GrowMulti":100,
	"TeleportMulti":100,
	"ItemTeleportMulti":100,
	"CleanseMulti":500,
	"DVDBounceMulti":100,
	"HoleMulti":500
}
const default_gamba_sandbox_dict : Dictionary = {
	"PlayerSpeedGamba":1,
	"GlideBootsGamba":1,
	"DashGamba":1,
	"expl_BGamba":1,
	"GrappleGamba":1,
	"FollowerGamba":1,
	"ShrinkGamba":1,
	"SlowGamba":1,
	"GrowGamba":1,
	"TeleportGamba":1,
	"ItemTeleportGamba":1,
	"CleanseGamba":1,
	"DVDBounceGamba":1,
	"HoleGamba":1
}
const default_shop_sandbox_dict : Dictionary = {
	"PlayerSpeedShop":1,
	"GlideBootsShop":1,
	"DashShop":1,
	"expl_BShop":1,
	"GrappleShop":1,
	"FollowerShop":1,
	"GambaShop":1,
	"ShieldShop":1,
	"ShrinkShop":1,
	"SlowShop":1,
	"GrowShop":1,
	"TeleportShop":1,
	"ItemTeleportShop":1,
	"CleanseShop":1,
	"DVDBounceShop":1,
	"HoleShop":1
}

const default_deal_sandbox_dict : Dictionary = {
	"PlayerSpeedDeal":1,
	"GlideBootsDeal":1,
	"DashDeal":1,
	"expl_BDeal":1,
	"GrappleDeal":1,
	"FollowerDeal":1,
	"GambaDeal":1,
	"ShieldDeal":1,
	"ShrinkDeal":1,
	"SlowDeal":1,
	"GrowDeal":1,
	"TeleportDeal":1,
	"ItemTeleportDeal":1,
	"CleanseDeal":1,
	"DVDBounceDeal":1,
	"HoleDeal":1
}

const default_sandbox_dict : Dictionary = {
	"General" : default_general_sandbox_dict,
	"Items" : default_items_sandbox_dict,
	"Multi" : default_multi_sandbox_dict,
	"Gamba" : default_gamba_sandbox_dict,
	"Shop" : default_shop_sandbox_dict,
	"Street" : default_street_sandbox_dict,
	"Deals" : default_deal_sandbox_dict
}

const default_sandbox_seed : String = ""
# aim toggle
const default_mouse_aim_toggle : bool = false
const default_controller_aim_toggle : bool = false

# tooltip data
const default_logbook_objects_dict : Dictionary = {
	"ExplBarrel":{"bools":[false, false], 
	"tooltip":
		"Exploding Barrel:
		-You can pick it up, throw it, and explode things! Omg wow that's crazy.
		-Picking them up will slow you down.",
	"popuptooltip":
		""},
	"Dumpster":{"bools":[false, false], 
	"tooltip":
		"Dumpster:
			-It's a dumpster. Go around it. Please. 
			-I don't know why the neighbors insist on keeping it there.
			-But... Sometimes the neighbors throw away some good stuff
			-They even hide little goodies in their cars.
			-Only one way to find out...",
	"popuptooltip":
		""},
	"Barrel":{"bools":[false, false], 
	"tooltip":
		"Barrel:
		-It's a barrel. It's kinda just for decoration. It can block you though.",
	"popuptooltip":
		""},
	"Hole_Sidewalk_Street":{"bools":[false, false], 
	"tooltip":
		"Hole:
	-Don't walk over it! The city really needs to do something about this pothole problem...
	-These holes could be quite useful at stopping these cars.
	If only there was a method to make them larger...",
	"popuptooltip":
		""}
}

const default_logbook_items_dict : Dictionary = {
	"PlayerSpeed":{"bools":[false, false], 
	"tooltip":
		"Player Speed:
		-Stacking increases the player's speed.
		-Stacking cap: Infinite",
	"popuptooltip":
		"Faster!"},
	"GlideBoots":{"bools":[false, false], 
	"tooltip":
		"Glide:
		-Activate: Glide without friction. You can not move normally, 
		but you can boost youself using other special items.
		-Activate while active: Cancel the glide early.
		-Stacking increases gliding time.
		-Stacking decreases cooldown.
		-Stacking cap: Infinite",
	"popuptooltip":
		"Activate it to go frictionless."},
	"Dash":{"bools":[false, false], 
	"tooltip":
		"Dash:
		-Activate: Gain a quick boost in speed, but you cannot change direction.
		-Stacking increases dashing speed.
		-Stacking decreases cooldown.
		-Stacking cap: Infinite",
	"popuptooltip":
		"Activate to gain a surge of uncontrolable speed."},
	"expl_B":{"bools":[false, false], 
	"tooltip":
		"Exploding Barrel (Expl-B.):
		-Stacking increases:
			Chances of finding Expl-B
			Distance when throwing Expl-B
			Expl-B explosion radius
		-Stacking decreases:
			Speed penalty when carrying Expl-B 
		-Stacking cap: Infinite",
	"popuptooltip":
		"Throw explosives farther. And better explosions!"},
	"Grapple":{"bools":[false, false], 
	"tooltip":
		"Grapple: 
		-Activate: Shoot a grappling rope which pulls you in a direction.
		-Passive: A rope will occasionally grab the farthest item on screen for you.
		-Stacking increases:
			Grapple speed
			Grapple pulling power
			Grapple distance
		-Stacking decreases:
			Active Grapple cooldown
			Passive Grapple cooldown
		-Stacking cap: Infinite",
	"popuptooltip":
		"Activate to shoot a grappling rope.
		Also gets far away items for you."},
	"Follower":{"bools":[false, false], 
	"tooltip":
		"Follower:
		-Produce a clone of yourself. Almost every item you pick up 
		is muliplied by the number of followers you have.
		-Stacking increases: Number of followers.
		-Stacking cap: Infinite",
	"popuptooltip":
		"Make a clone of yourself.
		More clones means more items!"},
	"Gamba":{"bools":[false, false], 
	"tooltip":
		"Random:
		-Grants you a random item/curse.
		-Stacking increases the stack of the random item/curse you receive.
		-Stacking cap: Infinite",
	"popuptooltip":
		"Gives you a random item/curse."},
	"Shield":{"bools":[false, false], 
	"tooltip":
		"Shield:
		-Provides a one time protection against cars and explosions.
		-Does not stack.",
	"popuptooltip":
		"A rare one time protection from danger!
		But it doesn't stack!"},
	"Shrink":{"bools":[false, false], 
	"tooltip":
		"Shrink:
		-Makes your character smaller.
		-Stacking decreases your size.
		-Stacking cap: 100",
	"popuptooltip":
		"Makes you smaller."},
	"Cleanse":{"bools":[false, false], 
	"tooltip":
		"Cleanse:
		-Removes one point of a random curse from you.",
	"popuptooltip":
		"Removes one point of a random curse from you."},
	"Hole":{"bools":[false, false], 
	"tooltip":
		"Coyote Time:
		-Prevents you from falling down a hole momentarily.
		-Stacking increases the protection time.
		-Stacking decreases Coyote Time cooldown.
		-Stacking cap: Infinite",
	"popuptooltip":
		"Prevents you from falling down a hole momentarily"}
}

const default_logbook_curses_dict : Dictionary = {
	"Slow":{"bools":[false, false], 
	"tooltip":
		"Slow:
		-Makes your character slower.
		-Stacking decreases your speed
		-Stacking cap: 99",
	"popuptooltip":
		"Makes your character slower."},
	"Grow":{"bools":[false, false], 
	"tooltip":
		"Grow:
		-Makes your character larger.
		-Stacking increases your size.
		-Stacking cap: 100",
	"popuptooltip":
		"Makes your character larger."},
	"Teleport":{"bools":[false, false], 
	"tooltip":
		"Teleport:
		-Periodically teleports you over a semi-random distance and direction.
		-Stacking decreases the teleport cooldown.
		-Stacking cap: Infinite",
	"popuptooltip":
		"Periodically teleports you."},
	"ItemTeleport":{"bools":[false, false], 
	"tooltip":
		"Item Teleport:
		-Has the capability to teleport a random item you have you over a random distance on screen periodically.
		-You lose the item as it's teleported, but you can still pick it up again.
		-Stacking decreases the teleport cooldown.
		-Stacking cap: Infinite",
	"popuptooltip":
		"Periodically teleports your items."},
	"DVDBounce":{"bools":[false, false], 
	"tooltip":
		"DVD Bounce:
		-Blocks your vision with a bouncing rectangle.
		-Stacking increases the number of rectangles.
		-Stacking cap: Infinite",
	"popuptooltip":
		"Blocks your vision with a bouncing rectangle."}
}

const default_logbook_dict : Dictionary = {
	"Objects":default_logbook_objects_dict,
	"Items":default_logbook_items_dict,
	"Curses":default_logbook_curses_dict
}

# show hitboxes
const default_show_hitboxes : bool = false
# show controls
const default_show_controls : bool = false
