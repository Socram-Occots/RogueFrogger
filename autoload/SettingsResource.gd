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
	"None_Sidewalk":800,
	"None_Street":800
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
	"Shop" : default_shop_sandbox_dict
}

const default_sandbox_seed : String = ""
# aim toggle
const default_mouse_aim_toggle : bool = false
const default_controller_aim_toggle : bool = false
