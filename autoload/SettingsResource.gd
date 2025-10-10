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
	"ExplBarrel":10,
	"Dumpster":50,
	"Barrel":90,
	"Shop":1,
	"Items":50,
	"None":800
}
const default_items_sandbox_dict : Dictionary = {
	"PlayerSpeed":50,
	"GlideBoots":50,
	"Dash":50,
	"expl_B":50,
	"Grapple":50,
	"Follower":5,
	"Gamba":50,
	"Shield":1,
	"Shrink":50,
	"Multi":100,
	"Cleanse":10
}
const default_multi_sandbox_dict : Dictionary = {
	"PlayerSpeedMulti":50,
	"GlideBootsMulti":50,
	"DashMulti":50,
	"expl_BMulti":50,
	"GrappleMulti":50,
	"FollowerMulti":5,
	"GambaMulti":50,
	"ShieldMulti":1,
	"ShrinkMulti":50,
	"SlowMulti":10,
	"GrowMulti":10,
	"LongTeleportMulti":10,
	"ShortTeleportMulti":10,
	"CleanseMulti":50,
	"DVDBounceMulti":10
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
	"DVDBounceGamba":1
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
	"DVDBounceShop":1
}
const default_sandbox_dict : Dictionary = {
	"General" : default_general_sandbox_dict,
	"Items" : default_items_sandbox_dict,
	"Multi" : default_multi_sandbox_dict,
	"Gamba" : default_gamba_sandbox_dict,
	"Shop" : default_shop_sandbox_dict
}
