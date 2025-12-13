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
# sandbox data
const default_general_sandbox_dict : Dictionary = {
	"ExplBarrel":50,
	"Dumpster":50,
	"Barrel":200,
	"Shop":5,
	"Items":50,
	"None":800,
	"Hole_Sidewalk":10
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
	"LongTeleportMulti":100,
	"ShortTeleportMulti":100,
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
	"LongTeleportGamba":1,
	"ShortTeleportGamba":1,
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
	"LongTeleportShop":1,
	"ShortTeleportShop":1,
	"CleanseShop":1,
	"DVDBounceShop":1,
	"HoleShop":1
}

const default_sandbox_dict : Dictionary = {
	"General" : default_general_sandbox_dict,
	"Items" : default_items_sandbox_dict,
	"Multi" : default_multi_sandbox_dict,
	"Gamba" : default_gamba_sandbox_dict,
	"Shop" : default_shop_sandbox_dict,
	"Street" : default_street_sandbox_dict
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
		-Picking them up will slow you down."},
	"Dumpster":{"bools":[false, false], 
	"tooltip":
		"Dumpster:
			-It's a dumpster. Go around it. Please. 
			-I don't know why the neighbors insist on keeping it there."},
	"Barrel":{"bools":[false, false], 
	"tooltip":
		"Barrel:
		-It's a barrel. Kinda just for decoration, can block you though."},
	"Hole_Sidewalk_Street":{"bools":[false, false], 
	"tooltip":
		"Hole:
	-Dont walk over it! The city really needs to do something about this pothole problem...
	-These holes could be quite useful at stopping these cars.
	If only there was a method to make them larger..."}
}

const default_logbook_items_dict : Dictionary = {
	"PlayerSpeed":{"bools":[false, false], 
	"tooltip":
		"Player Speed:
		-Stacking increases the player's speed.
		-Stacking cap: Infinite"},
	"GlideBoots":{"bools":[false, false], 
	"tooltip":
		"Glide:
		-Activate: Glide without friction. You can not move normally, 
		but you can boost youself using othe special items.
		-Activate while active: Cancel the glide early.
		-Stacking increases gliding time.
		-Stacking decreases cooldown.
		-Stacking cap: Infinite"},
	"Dash":{"bools":[false, false], 
	"tooltip":
		"Dash:
		-Activate: Gain a quick boost in speed, but you cannot change direction.
		-Stacking increases dashing speed.
		-Stacking decreases cooldown.
		-Stacking cap: Infinite"},
	"expl_B":{"bools":[false, false], 
	"tooltip":
		"Exploding Barrel (Expl-B.):
		-Stacking increases:
			Chances of finding Expl-B
			Distance when throwing Expl-B
			Expl-B explosion radius
		-Stacking decreases:
			Speed penalty when carrying Expl-B 
		-Stacking cap: Infinite"},
	"Grapple":{"bools":[false, false], 
	"tooltip":
		"Grapple: 
		-Activate: Shoot a grappling rope that pulls you once it hits a target.
		-Passive: A rope will occasionally grab the farthest item on screen for you.
		-Stacking increases:
			Grapple speed
			Grapple pulling power
			Grapple distance
		-Stacking decreases:
			Active Grapple cooldown
			Passive Grapple cooldown
		-Stacking cap: Infinite"},
	"Follower":{"bools":[false, false], 
	"tooltip":
		"Follower:
		-Produce a clone of yourself. Almost every item you recieve is
		muliplied by the number of followers you have.
		-Stacking increases: Number of followers.
		-Stacking cap: Infinite"},
	"Gamba":{"bools":[false, false], 
	"tooltip":
		"Random:
		-Grants you a random item/curse.
		-Stacking increases the stack of the random item/curse you receive.
		-Stacking cap: Infinite"},
	"Shield":{"bools":[false, false], 
	"tooltip":
		"Shield:
		-Provides a one time protection against cars and explosions.
		-Does not stack."},
	"Shrink":{"bools":[false, false], 
	"tooltip":
		"Shrink:
		-Makes your character smaller.
		-Stacking decreases your size.
		-Stacking cap: 100"},
	"Cleanse":{"bools":[false, false], 
	"tooltip":
		"Cleanse:
		-Removes one stack of a random curse."},
	"Hole":{"bools":[false, false], 
	"tooltip":
		"Coyote Time:
		-Prevents you from falling down a hole momentarily.
		-Stacking increases the protection time.
		-Stacking decreases Coyote Time cooldown.
		-Stacking cap: Infinite"}
}

const default_logbook_curses_dict : Dictionary = {
	"Slow":{"bools":[false, false], 
	"tooltip":
		"Slow:
		-Makes your character slower.
		-Stacking decreases your speed
		-Stacking cap: 99"},
	"Grow":{"bools":[false, false], 
	"tooltip":
		"Grow:
		-Makes your character larger.
		-Stacking increases your size.
		-Stacking cap: 100"},
	"LongTeleport":{"bools":[false, false], 
	"tooltip":
		"Long Teleport:
		-Has the capability to teleport you over a random long distance on screen once.
		-Stacking cap: Infinite"},
	"ShortTeleport":{"bools":[false, false], 
	"tooltip":
		"Short Teleport:
		-Has the capability to teleport you over a random short distance on screen periodically.
		-Stacking decreases the teleport cooldown.
		-Stacking cap: Infinite"},
	"DVDBounce":{"bools":[false, false], 
	"tooltip":
		"DVD Bounce:
		-Blocks your vision with a bouncing rectangle.
		-Stacking increases the number of rectangles.
		-Stacking cap: Infinite"}
}

const default_logbook_dict : Dictionary = {
	"Objects":default_logbook_objects_dict,
	"Items":default_logbook_items_dict,
	"Curses":default_logbook_curses_dict
}

# show hitboxes
const default_show_hitboxes : bool = false
