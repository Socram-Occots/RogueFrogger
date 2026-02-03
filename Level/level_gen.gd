# level_gen.gd
extends Node

@onready var SPAWN_LIST : Array[String] = []
@onready var CHANCE_LIST : Array[float] = []
@onready var ITEMS_LIST : Array[String] = []
@onready var ITEMS_CHANCE_LIST : Array[float] = []

@onready var BORDERS : Array = []
@onready var TERRAIN : Array = []

@onready var dashpopup : bool = true 
@onready var line : Area2D = null
@onready var hboxlabels : HBoxContainer = $CanvasLayer/HBoxContainer 
@onready var canvas_layer : CanvasLayer = $CanvasLayer

@onready var curr_follower_id : int = 1

@onready var sidewalk : bool = false

@onready var MULTI_LIST : Array[String] = []
@onready var MULTI_CHANCE_LIST : Array[int] = []

@onready var shoppriceitems_c_nEmpty : bool = false
@onready var shoppriceitems_l_nEmpty : bool = false
@onready var shoppriceitems_m_nEmpty  : bool = false
@onready var shoppriceitems_h_nEmpty  : bool = false
@onready var shopproductitems_l_nEmpty : bool = false
@onready var shopproductitems_m_nEmpty  : bool = false
@onready var shopproductitems_h_nEmpty  : bool = false
@onready var shop_is_closed : bool = false

@onready var dealitems_l_nEmpty : bool = false
@onready var dealitems_m_nEmpty : bool = false
@onready var dealitems_h_nEmpty : bool = false
@onready var dealcurses_l_nEmpty : bool = false
@onready var deal_is_closed : bool = false

@onready var shopitemtier : Array[String] = []
@onready var shopitemtierchances : Array[int] = []
#@onready var dealitemtier : Array[String] = []
#@onready var dealitemtierchances : Array[int] = []

@onready var itemtierchancedict : Dictionary = {
	"l->h":2,"l->m":3,"l->l":5,
	"m->l":1,"m->m":5,"m->h":2,
	"h->l":1,"h->m":1,"h->h":1,
	"c->l":2,"c->m":2,"c->h":1
}
@onready var itemtierdealdict : Dictionary = {
	"l":4,"m":2,"h":1
}
@onready var itemtierdeal : Array[String] = []
@onready var itemtierdealchances : Array[int] = []

@onready var itemtierinventory : Dictionary = {
	"l->h":[[],[]],"l->m":[[],[]],"l->l":[[],[]],
	"m->l":[[],[]],"m->m":[[],[]],"m->h":[[],[]],
	"h->l":[[],[]],"h->m":[[],[]],"h->h":[[],[]],
	"c->l":[[],[]],"c->m":[[],[]],"c->h":[[],[]]
}

@onready var itemtierprices : Dictionary = {
	"l->h":[4,4,0,2],"l->m":[3,4,2,4],"l->l":[0,4,0,4],
	"m->l":[2,4,4,4],"m->m":[0,4,0,4],"m->h":[3,3,1,3],
	"h->l":[0,2,4,7],"h->m":[0,2,3,6],"h->h":[0,2,0,2],
	"c->l":[0,1,0,1],"c->m":[0,1,0,1],"c->h":[0,1,0,1]
}

@onready var dealtierprices : Dictionary = {
	"l":[4,4,0,2],"m":[3,3,3,3],"h":[1,3,6,6]
}

@onready var itemtierdict : Dictionary = {
	"shoppriceitems" : {
		"c": [],
		"l": [],
		"m": [],
		"h": []
	},"shopproductitems" : {
		"l": [],
		"m": [],
		"h": []
	},"dealitems" : {
		"l": [],
		"m": [],
		"h": []
	},"dealcurses" : {
		"c": []
	}
}

@onready var shopitemtierdictref : Dictionary = {
	"GlideBootsShop":"l", "expl_BShop":"l", "GrappleShop":"l", "HoleShop":"l",
	"DashShop":"m", "GambaShop":"m", "ShrinkShop":"m", "CleanseShop":"m",
	"PlayerSpeedShop":"h", "FollowerShop":"h", "ShieldShop":"h",
	"DVDBounceShop":"c", "ItemTeleportShop":"c", "TeleportShop":"c", 
	"GrowShop":"c", "SlowShop":"c"
}
@onready var dealitemtierdictref : Dictionary = {
	"GlideBootsDeal":"l", "expl_BDeal":"l", "GrappleDeal":"l", "HoleDeal":"l",
	"DashDeal":"m", "GambaDeal":"m", "ShrinkDeal":"m", "CleanseDeal":"m",
	"PlayerSpeedDeal":"h", "FollowerDeal":"h", "ShieldDeal":"h",
	"DVDBounceDeal":"c", "ItemTeleportDeal":"c", "TeleportDeal":"c", 
	"GrowDeal":"c", "SlowDeal":"c"
}

@onready var gamba_array_good : Array[Array] = []
@onready var gamba_array_bad : Array[Array] = []

@onready var gamba_picker : Node

# icons
@onready var playerspeedicon : VBoxContainer = Globalpreload.playerspeedicon.duplicate()
@onready var glideicon : VBoxContainer = Globalpreload.glideicon.duplicate()
@onready var dashicon : VBoxContainer = Globalpreload.dashicon.duplicate()
@onready var expl_B_icon : VBoxContainer = Globalpreload.expl_B_icon.duplicate()
@onready var grapple_icon : VBoxContainer = Globalpreload.grapple_icon.duplicate()
@onready var follower_icon : VBoxContainer = Globalpreload.follower_icon.duplicate()
@onready var shrink_icon : VBoxContainer = Globalpreload.shrink_icon.duplicate()
@onready var slow_icon : VBoxContainer = Globalpreload.slow_icon.duplicate()
@onready var grow_icon : VBoxContainer = Globalpreload.grow_icon.duplicate()
@onready var tele_icon : VBoxContainer = Globalpreload.tele_icon.duplicate()
@onready var itemtele_icon : VBoxContainer = Globalpreload.itemtele_icon.duplicate()
@onready var cleanse_icon : VBoxContainer = Globalpreload.cleanse_icon.duplicate()
@onready var dvdbounce_icon : VBoxContainer = Globalpreload.dvdbounce_icon.duplicate()
@onready var hole_icon : VBoxContainer = Globalpreload.hole_icon.duplicate()

# textures
@onready var playerspeedglowicon : Texture2D = Globalpreload.playerspeedglowicon.duplicate()
@onready var glideglowicon : Texture2D = Globalpreload.glideglowicon.duplicate()
@onready var dashglowicon : Texture2D =  Globalpreload.dashglowicon.duplicate()
@onready var expl_B_glowicon : Texture2D =  Globalpreload.expl_B_glowicon.duplicate()
@onready var grapple_glowicon : Texture2D =  Globalpreload.grapple_glowicon.duplicate()
@onready var follower_glowicon : Texture2D =  Globalpreload.follower_glowicon.duplicate()
@onready var shrink_glowicon : Texture2D =  Globalpreload.shrink_glowicon.duplicate()
@onready var gamba_glowicon : Texture2D =  Globalpreload.gamba_glowicon.duplicate()
@onready var shield_glowicon : Texture2D =  Globalpreload.shield_glowicon.duplicate()
@onready var slow_glowicon : Texture2D =  Globalpreload.slow_glowicon.duplicate()
@onready var grow_glowicon : Texture2D =  Globalpreload.grow_glowicon.duplicate()
@onready var tele_glowicon : Texture2D =  Globalpreload.tele_glowicon.duplicate()
@onready var itemtele_glowicon : Texture2D =  Globalpreload.itemtele_glowicon.duplicate()
@onready var cleanse_glowicon : Texture2D =  Globalpreload.cleanse_glowicon.duplicate()
@onready var dvdbounce_glowicon : Texture2D =  Globalpreload.dvdbounce_glowicon.duplicate()
@onready var hole_glowicon : Texture2D =  Globalpreload.hole_glowicon.duplicate()

# dvd area
@onready var DVDarea : Node2D = Globalpreload.DVDarea.duplicate()

@onready var losepopup : Control
@onready var pausepopup : Control 

@onready var arr_to_del : Array = [playerspeedicon, glideicon, dashicon,expl_B_icon,grapple_icon,
follower_icon,shrink_icon,slow_icon,grow_icon,tele_icon,itemtele_icon,cleanse_icon,
dvdbounce_icon,DVDarea,losepopup,pausepopup,hole_icon]

# multichances
@onready var multi_num_limit : int

# shopchances
@onready var shop_num_limit : int = 15

@onready var expl_Bidx : int = -1

@onready var high_score_reached : bool = false

@onready var STREET_SPAWN_LIST : Array[String] = []
@onready var STREET_CHANCE_LIST : Array[float] = []

# tooltips
@onready var controls_tooltip: VBoxContainer = $CanvasLayer/ControlsTooltip

# speedrun
@onready var speed_run_checkpoints : Dictionary = {
	100: true,
	250: true,
	500: true,
	750: true,
	1000: true,
}

func load_element_stats() -> void:
	load_general_stats()
	load_street_stats()
	load_items_stats()
	load_multi_stats()
	load_gamba_stats()
	load_shop_stats()
	load_deals_stats()
	load_seed()
	load_misc_stats()

func return_dict_stats(topic : String) -> Dictionary:
	var return_dict : Dictionary
	if Global.challenge:
		return_dict = SettingsDataContainer.get_challenges_dict(
			Global.challenge_curr)["SandboxDict"][topic]
	else:
		return_dict = SettingsDataContainer.get_sandbox_dict_type(
			topic, !Global.sandbox)
	return return_dict

func return_dict_key_stats(topic : String) -> Array:
	var return_keys := SettingsDataContainer.get_sandbox_dict_type(
		topic, true).keys()
	return return_keys

func load_general_stats() -> void:
	var gen_dict : Dictionary = return_dict_stats("General")
	var default_keys := return_dict_key_stats("General")
	var gen_dict_keys := gen_dict.keys()
	for i in range(0, gen_dict_keys.size()):
		var tempstring : String = gen_dict_keys[i]
		# this check is a fail safe so left over keys dont mess things up before
		# the game is saved
		if tempstring in default_keys:
			var tempint : int = gen_dict[tempstring]
			if tempint > 0:
				SPAWN_LIST.append(tempstring)
				CHANCE_LIST.append(tempint)
	expl_Bidx = SPAWN_LIST.find("expl_B")

func load_street_stats() -> void:
	var str_dict : Dictionary = return_dict_stats("Street")
	var default_keys := return_dict_key_stats("Street")
	var str_dict_keys := str_dict.keys()
	for i in range(0, str_dict_keys.size()):
		var tempstring : String = str_dict_keys[i]
		if tempstring in default_keys:
			var tempint : int = str_dict[tempstring]
			if tempint > 0:
				STREET_SPAWN_LIST.append(tempstring)
				STREET_CHANCE_LIST.append(tempint)

func load_items_stats() -> void:
	var item_dict : Dictionary = return_dict_stats("Items")
	var default_keys := return_dict_key_stats("Items")
	var item_dict_keys := item_dict.keys()
	for i in range(0, item_dict_keys.size()):
		var tempstring : String =  item_dict_keys[i]
		if tempstring in default_keys:
			var tempint : int = item_dict[tempstring]
			if tempint > 0:
				ITEMS_LIST.append(tempstring)
				ITEMS_CHANCE_LIST.append(tempint)

func load_multi_stats() -> void:
	var multi_dict : Dictionary = return_dict_stats("Multi")
	var default_keys := return_dict_key_stats("Multi")
	var multi_dict_keys := multi_dict.keys()
	for i in range(0, multi_dict_keys.size()):
		var tempstring : String = multi_dict_keys[i]
		if tempstring in default_keys:
			var tempint : int = multi_dict[tempstring]
			if tempint > 0:
				MULTI_LIST.append(tempstring)
				MULTI_CHANCE_LIST.append(tempint)
	multi_num_limit = MULTI_LIST.size()

func load_misc_stats() -> void:
	var misc_dict : Dictionary = return_dict_stats("Misc")
	# load car speed modifier
	Global.sandbox_car_speed_mod = misc_dict["CarSpeed"]/100.0

func get_Icon_texture2D(containter : VBoxContainer) -> Texture2D:
	return containter.get_node("Sprite2D").texture

func load_gamba_stats() -> void:
	var gamba_dict : Dictionary = return_dict_stats("Gamba")
	var default_keys := return_dict_key_stats("Gamba")
	var gamba_dict_keys := gamba_dict.keys()
	for i in range(0, gamba_dict_keys.size()):
		var tempstring : String = gamba_dict_keys[i]
		if tempstring in default_keys:
			var tempint : int = gamba_dict[tempstring]
			if tempint > 0:
				match tempstring:
					"PlayerSpeedGamba":
						gamba_array_good.append([tempstring, 
						get_Icon_texture2D(playerspeedicon)])
					"GlideBootsGamba":
						gamba_array_good.append([tempstring, 
						get_Icon_texture2D(glideicon)])
					"DashGamba":
						gamba_array_good.append([tempstring, 
						get_Icon_texture2D(dashicon)])
					"expl_BGamba":
						gamba_array_good.append([tempstring, 
						get_Icon_texture2D(expl_B_icon)])
					"GrappleGamba":
						gamba_array_good.append([tempstring, 
						get_Icon_texture2D(grapple_icon)])
					"FollowerGamba":
						gamba_array_good.append([tempstring, 
						get_Icon_texture2D(follower_icon)])
					"ShrinkGamba":
						gamba_array_good.append([tempstring, 
						get_Icon_texture2D(shrink_icon)])
					"CleanseGamba":
						gamba_array_good.append([tempstring, 
						get_Icon_texture2D(cleanse_icon)])
					"SlowGamba":
						gamba_array_bad.append([tempstring, 
						get_Icon_texture2D(slow_icon)])
					"GrowGamba":
						gamba_array_bad.append([tempstring, 
						get_Icon_texture2D(grow_icon)])
					"TeleportGamba":
						gamba_array_bad.append([tempstring, 
						get_Icon_texture2D(tele_icon)])
					"ItemTeleportGamba":
						gamba_array_bad.append([tempstring, 
						get_Icon_texture2D(itemtele_icon)])
					"DVDBounceGamba":
						gamba_array_bad.append([tempstring, 
						get_Icon_texture2D(dvdbounce_icon)])
					"HoleGamba":
						gamba_array_good.append([tempstring, 
						get_Icon_texture2D(hole_icon)])
					_: print("Could not pre load gamba: ", tempstring)

func load_shop_stats() -> void:
	var shop_dict : Dictionary = return_dict_stats("Shop")
	var default_keys := return_dict_key_stats("Shop")
	var shop_dict_keys := shop_dict.keys()
	for i in range(0, shop_dict_keys.size()):
		var tempstring : String = shop_dict_keys[i]
		if tempstring in default_keys:
			var tempint : int = shop_dict[tempstring]
			if tempint > 0:
				if tempstring in \
				["DVDBounceShop", "ItemTeleportShop", "TeleportShop",
				"GrowShop", "SlowShop"]:
					itemtierdict["shoppriceitems"][shopitemtierdictref[tempstring]].append(tempstring)
				elif tempstring in \
				["PlayerSpeedShop","GlideBootsShop","DashShop","expl_BShop",
				"GrappleShop", "ShrinkShop", "HoleShop", "FollowerShop"]:
					itemtierdict["shoppriceitems"][shopitemtierdictref[tempstring]].append(tempstring)
					itemtierdict["shopproductitems"][shopitemtierdictref[tempstring]].append(tempstring)
				elif  tempstring in \
				["GambaShop", "CleanseShop", "ShieldShop"]:
					itemtierdict["shopproductitems"][shopitemtierdictref[tempstring]].append(tempstring)
	
	shoppriceitems_l_nEmpty = itemtierdict["shoppriceitems"]["l"].size() > 0
	shoppriceitems_m_nEmpty = itemtierdict["shoppriceitems"]["m"].size() > 0
	shoppriceitems_h_nEmpty = itemtierdict["shoppriceitems"]["h"].size() > 0
	shoppriceitems_c_nEmpty = itemtierdict["shoppriceitems"]["c"].size() > 0
	shopproductitems_l_nEmpty = itemtierdict["shopproductitems"]["l"].size() > 0
	shopproductitems_m_nEmpty = itemtierdict["shopproductitems"]["m"].size() > 0
	shopproductitems_h_nEmpty = itemtierdict["shopproductitems"]["h"].size() > 0
	
	itemtierinventory["l->l"][0] = itemtierdict["shoppriceitems"]["l"]
	itemtierinventory["l->l"][1] = itemtierdict["shopproductitems"]["l"]
	itemtierinventory["l->m"][0] = itemtierdict["shoppriceitems"]["l"]
	itemtierinventory["l->m"][1] = itemtierdict["shopproductitems"]["m"]
	itemtierinventory["l->h"][0] = itemtierdict["shoppriceitems"]["l"]
	itemtierinventory["l->h"][1] = itemtierdict["shopproductitems"]["h"]
	itemtierinventory["m->l"][0] = itemtierdict["shoppriceitems"]["m"]
	itemtierinventory["m->l"][1] = itemtierdict["shopproductitems"]["l"]
	itemtierinventory["m->m"][0] = itemtierdict["shoppriceitems"]["m"]
	itemtierinventory["m->m"][1] = itemtierdict["shopproductitems"]["m"]
	itemtierinventory["m->h"][0] = itemtierdict["shoppriceitems"]["m"]
	itemtierinventory["m->h"][1] = itemtierdict["shopproductitems"]["h"]
	itemtierinventory["h->l"][0] = itemtierdict["shoppriceitems"]["h"]
	itemtierinventory["h->l"][1] = itemtierdict["shopproductitems"]["l"]
	itemtierinventory["h->m"][0] = itemtierdict["shoppriceitems"]["h"]
	itemtierinventory["h->m"][1] = itemtierdict["shopproductitems"]["m"]
	itemtierinventory["h->h"][0] = itemtierdict["shoppriceitems"]["h"]
	itemtierinventory["h->h"][1] = itemtierdict["shopproductitems"]["h"]
	itemtierinventory["c->l"][0] = itemtierdict["shoppriceitems"]["c"]
	itemtierinventory["c->l"][1] = itemtierdict["shopproductitems"]["l"]
	itemtierinventory["c->m"][0] = itemtierdict["shoppriceitems"]["c"]
	itemtierinventory["c->m"][1] = itemtierdict["shopproductitems"]["m"]
	itemtierinventory["c->h"][0] = itemtierdict["shoppriceitems"]["c"]
	itemtierinventory["c->h"][1] = itemtierdict["shopproductitems"]["h"]
	
	if shoppriceitems_l_nEmpty:
		if shopproductitems_l_nEmpty:
			shopitemtier.append("l->l")
			shopitemtierchances.append(itemtierchancedict["l->l"])
		if shopproductitems_m_nEmpty:
			shopitemtier.append("l->m")
			shopitemtierchances.append(itemtierchancedict["l->m"])
		if shopproductitems_h_nEmpty:
			shopitemtier.append("l->h")
			shopitemtierchances.append(itemtierchancedict["l->h"])
	if shoppriceitems_m_nEmpty:
		if shopproductitems_m_nEmpty:
			shopitemtier.append("m->m")
			shopitemtierchances.append(itemtierchancedict["m->m"])
		if shopproductitems_l_nEmpty:
			shopitemtier.append("m->l")
			shopitemtierchances.append(itemtierchancedict["m->l"])
		if shopproductitems_h_nEmpty:
			shopitemtier.append("m->h")
			shopitemtierchances.append(itemtierchancedict["m->h"])
	if shoppriceitems_h_nEmpty:
		if shopproductitems_h_nEmpty:
			shopitemtier.append("h->h")
			shopitemtierchances.append(itemtierchancedict["h->h"])
		if shopproductitems_l_nEmpty:
			shopitemtier.append("h->l")
			shopitemtierchances.append(itemtierchancedict["h->l"])
		if shopproductitems_m_nEmpty:
			shopitemtier.append("h->m")
			shopitemtierchances.append(itemtierchancedict["h->m"])
	if shoppriceitems_c_nEmpty:
		if shopproductitems_l_nEmpty:
			shopitemtier.append("c->l")
			shopitemtierchances.append(itemtierchancedict["c->l"])
		if shopproductitems_m_nEmpty:
			shopitemtier.append("c->m")
			shopitemtierchances.append(itemtierchancedict["c->m"])
		if shopproductitems_h_nEmpty:
			shopitemtier.append("c->h")
			shopitemtierchances.append(itemtierchancedict["c->h"])
	
	shop_is_closed = !(shoppriceitems_c_nEmpty || shoppriceitems_l_nEmpty || \
	shoppriceitems_m_nEmpty || shoppriceitems_h_nEmpty) ||\
	 !(shopproductitems_l_nEmpty || shopproductitems_m_nEmpty || shopproductitems_h_nEmpty)

func load_deals_stats() -> void:
	var deals_dict : Dictionary = return_dict_stats("Deals")
	var default_keys := return_dict_key_stats("Deals")
	var deals_dict_keys := deals_dict.keys()
	for i in range(0, deals_dict_keys.size()):
		var tempstring : String = deals_dict_keys[i]
		if tempstring in default_keys:
			var tempint : int = deals_dict[tempstring]
			if tempint > 0:
				if tempstring in \
				["PlayerSpeedDeal","GlideBootsDeal","DashDeal","expl_BDeal", "GrappleDeal",
				"ShrinkDeal", "HoleDeal", "GambaDeal", "CleanseDeal", "FollowerDeal", 
				"ShieldDeal"]:
					itemtierdict["dealitems"][dealitemtierdictref[tempstring]].append(tempstring)
				elif tempstring in \
				["DVDBounceDeal", "ItemTeleportDeal", "TeleportDeal", "GrowDeal", "SlowDeal",]:
					itemtierdict["dealcurses"][dealitemtierdictref[tempstring]].append(tempstring)
	dealitems_l_nEmpty = itemtierdict["dealitems"]["l"].size() > 0
	dealitems_m_nEmpty = itemtierdict["dealitems"]["m"].size() > 0
	dealitems_h_nEmpty = itemtierdict["dealitems"]["h"].size() > 0
	dealcurses_l_nEmpty = itemtierdict["dealcurses"]["c"].size() > 0
	if dealitems_l_nEmpty: 
		itemtierdeal.append("l")
		itemtierdealchances.append(itemtierdealdict["l"])
	if dealitems_m_nEmpty:
		itemtierdeal.append("m")
		itemtierdealchances.append(itemtierdealdict["m"])
	if dealitems_h_nEmpty:
		itemtierdeal.append("h")
		itemtierdealchances.append(itemtierdealdict["h"])
		
	deal_is_closed = !(dealitems_l_nEmpty || dealitems_m_nEmpty || dealitems_h_nEmpty) || \
	!dealcurses_l_nEmpty
	
func load_seed() -> void:
	var seedy : String = SettingsDataContainer.get_sandbox_seed(
		!Global.sandbox)
	if seedy:
		var converted_seed : int = seedy.to_int()
		if converted_seed == 0:
			converted_seed = hash(seedy)
		GRand.maprand.set_seed(converted_seed)
		GRand.itemrand.set_seed(converted_seed)
	else:
		GRand.maprand.randomize()
		GRand.itemrand.randomize()

func load_starter_items() -> void:
	if !Global.challenge: return
	var starterdict : Dictionary = SettingsDataContainer.get_challenges_dict(
		Global.challenge_curr)["StartingItems"]
	for i in starterdict.keys():
		match i:
			"PlayerSpeed":
				Global.inc_PlayerSpeed(starterdict[i])
			"GlideBoots":
				Global.inc_GlideBoots(starterdict[i])
			"Dash":
				Global.inc_Dash(starterdict[i])
			"expl_B":
				Global.inc_expl_B(starterdict[i])
			"Grapple":
				Global.inc_GrappleRope(starterdict[i])
			"Follower":
				Global.inc_Follower(starterdict[i])
			"Gamba":
				Global.inc_Gamba(starterdict[i])
			"Shield":
				Global.follower_array[0].shield_up = true
			"Shrink":
				Global.inc_Shrink(starterdict[i])
			"Cleanse":
				Global.cleanse_curse(starterdict[i])
			"Hole":
				Global.inc_Hole(starterdict[i])
			"SlowMulti":
				Global.inc_PlayerSlow(starterdict[i])
			"GrowMulti":
				Global.inc_Grow(starterdict[i])
			"TeleportMulti":
				Global.inc_Tele(starterdict[i])
			"ItemTeleportMulti":
				Global.inc_ItemTele(starterdict[i])
			"DVDBounceMulti":
				Global.inc_DVD(starterdict[i])

func objectSpawn(spawns : Array[String] = SPAWN_LIST, 
chances : Array[float] = CHANCE_LIST, node_num: int = 15) -> void:
	var spawn_length : int = spawns.size()
	var chances_length : int = chances.size()

	# both arrays need to be same length and exist
	if spawn_length != chances_length || spawns.is_empty(): return

	# at least one space must be open
	var open : int  = GRand.maprand.randi_range(0, node_num - 1)
	
	var i : int = 0
	# adding ingame modified item chances
	if expl_Bidx != -1:
		chances[expl_Bidx] += Global.expl_B_chance_mod
	
	var selected : int = -1
	while i < node_num:
		if i == open: i += 1
		if i == node_num: break
		var dir : String = "spawnterrain/Node" + str(i)
		var lucky_spawn : String
		if chances.is_empty():
			lucky_spawn = "None"
		else:
			selected = GRand.maprand.rand_weighted(chances)
			lucky_spawn = spawns[selected]
		
		var dirposition : Vector2 = get_node(dir).global_position
		
		# spawn the lucky object
		match lucky_spawn:
			"None": pass
			"Items": chooseItem(dirposition, i)
			"Barrel": i = spawnBarrel(dirposition, i)
			"Dumpster": i = spawnDumpster(dirposition, node_num, i)
			"ExplBarrel": i = spawnExplBarrel(dirposition, i)
			"Shop" : i = spawnShop(dirposition, node_num, i)
			"Hole_Sidewalk" : i = spawnHole(dirposition, i)
			"Deals" : i = spawnDeal(dirposition, node_num, i)
			_: print("This randomly selected object does not exist!:", lucky_spawn)
			
		i += 1
	# removing in-game modified chances so the don't stack every spawn request
	if expl_Bidx != -1:
		chances[expl_Bidx] -= Global.expl_B_chance_mod
		# extra precaution in case we somehow go negative
		chances[expl_Bidx] = abs(chances[expl_Bidx])

func chooseItem(dirposition : Vector2, i : int, items : Array[String] = ITEMS_LIST, 
items_chances : Array[float] = ITEMS_CHANCE_LIST) -> int:
	var item_length : int = items.size()
	var item_chances_length : int = items_chances.size()
	
	# both arrays need to be same length and exist
	if item_length != item_chances_length || items.is_empty(): return i
	
	var selected_item : int = GRand.maprand.rand_weighted(items_chances)
	var lucky_spawn : String = items[selected_item]
		# spawn the lucky item
	match lucky_spawn:
		"None": pass
		"PlayerSpeed": i = spawnItems(dirposition, lucky_spawn, i)
		"GlideBoots": i = spawnItems(dirposition, lucky_spawn, i)
		"Dash": i = spawnItems(dirposition, lucky_spawn, i)
		"expl_B": i = spawnItems(dirposition, lucky_spawn, i)
		"Grapple": i = spawnItems(dirposition, lucky_spawn, i)
		"Shield": i = spawnItems(dirposition, lucky_spawn, i)
		"Gamba": i = spawnItems(dirposition, lucky_spawn,i)
		"Follower": i = spawnItems(dirposition, lucky_spawn,i)
		"Shrink": i = spawnItems(dirposition,lucky_spawn, i)
		"Multi": i = spawnItems(dirposition,lucky_spawn, i)
		"Cleanse": i = spawnItems(dirposition,lucky_spawn, i)
		"Hole" : i = spawnItems(dirposition,lucky_spawn, i)
		_: print("This randomly selected item does not exist!:", lucky_spawn)
	
	return i

func spawnStreetObjects(spawns : Array[String] = STREET_SPAWN_LIST, 
chances : Array[float] = STREET_CHANCE_LIST, 
items : Array[String] = [], 
items_chances : Array[float] = [], 
node_num: int = 15) -> void:
	var spawn_length : int = spawns.size()
	var chances_length : int = chances.size()
	var item_length : int = items.size()
	var item_chances_length : int = items_chances.size()

	# both arrays need to be same length and exist
	if spawn_length != chances_length \
	|| item_length != item_chances_length: return

	# at least one space must be open
	var open : int  = GRand.maprand.randi_range(0, node_num - 1)
	
	var i : int = 0
	# adding ingame modified item chances
	
	var selected : int = -1
	while i < node_num:
		if i == open: i += 1
		if i == node_num: break
		var dir : String = "spawnterrain/Node" + str(i)
		var lucky_spawn : String
		if chances.is_empty():
			lucky_spawn = "None_Street"
		else:
			selected = GRand.maprand.rand_weighted(chances)
			lucky_spawn = spawns[selected]
		
		var dirposition : Vector2 = get_node(dir).global_position
		
		# spawn the lucky item
		match lucky_spawn:
			"None_Street": pass
			"Hole_Street" : i = spawnHole(dirposition, i)
			_: print("This randomly selected street item does not exist!:", lucky_spawn)
			
		i += 1

func multiItemPicker(mulit_list : Array[String] = MULTI_LIST,
multi_chance_list : Array[int] = MULTI_CHANCE_LIST, num_of_multi : int = multi_num_limit) -> Array[Array]:
	var result_multi_list : Array[Array] = []
	var mulit_list_copy = mulit_list.duplicate(true)
	var multi_chance_list_copy = multi_chance_list.duplicate(true)
	var lucky_multi : String
	
	var multi_quantity : int = floor(abs(GRand.maprand.randfn(0, 3)) + 2)

	if multi_quantity > num_of_multi: 
		multi_quantity = num_of_multi

	result_multi_list.resize(multi_quantity)
	for i in range(0, multi_quantity):
		
		var selected_multi : int = GRand.maprand.rand_weighted(multi_chance_list_copy)
		lucky_multi = mulit_list_copy[selected_multi]
		# spawn the lucky item
		match lucky_multi:
			"None": pass
			"PlayerSpeedMulti": result_multi_list[i] = [lucky_multi, playerspeedglowicon]
			"GlideBootsMulti": result_multi_list[i] = [lucky_multi,glideglowicon]
			"DashMulti": result_multi_list[i] = [lucky_multi, dashglowicon]
			"expl_BMulti": result_multi_list[i] = [lucky_multi, expl_B_glowicon]
			"GrappleMulti": result_multi_list[i] = [lucky_multi, grapple_glowicon]
			"ShieldMulti": result_multi_list[i] = [lucky_multi, shield_glowicon]
			"GambaMulti": result_multi_list[i] = [lucky_multi, gamba_glowicon]
			"FollowerMulti": result_multi_list[i] = [lucky_multi, follower_glowicon]
			"ShrinkMulti": result_multi_list[i] = [lucky_multi, shrink_glowicon]
			"SlowMulti": result_multi_list[i] = [lucky_multi, slow_glowicon]
			"GrowMulti": result_multi_list[i] = [lucky_multi, grow_glowicon]
			"TeleportMulti": result_multi_list[i] = [lucky_multi, tele_glowicon]
			"ItemTeleportMulti": result_multi_list[i] = [lucky_multi, itemtele_glowicon]
			"CleanseMulti": result_multi_list[i] = [lucky_multi, cleanse_glowicon]
			"DVDBounceMulti": result_multi_list[i] = [lucky_multi, dvdbounce_glowicon]
			"HoleMulti": result_multi_list[i] = [lucky_multi, hole_glowicon]
			_: print("This randomly selected multi does not exist!:", lucky_multi)
		
		multi_chance_list_copy.remove_at(selected_multi)
		mulit_list_copy.remove_at(selected_multi)
	return result_multi_list

func rand_vector_variance(pos : float) -> Vector2:
	var postemp : float =  abs(pos)
	return Vector2(GRand.maprand.randf_range(-1 * postemp, postemp), 
	GRand.maprand.randf_range(-1 * postemp, postemp))

func spawnBarrel(dir : Vector2, i : int) -> int:
	var barrel : StaticBody2D = Globalpreload.BARREL_INST.duplicate()
	barrel.visible = true
	barrel.position = dir + rand_vector_variance(25)
	$Ysort.add_child(barrel)
	return i

func spawnDumpster(dir : Vector2, node_num : int, i : int) -> int:
	# we have to check if this is the last node to prevent clipping out of bounds
	if i + 1 >= node_num: return i
	var dump : StaticBody2D = Globalpreload.DUMP_INST.duplicate()
	dump.visible = true
	dump.position = dir
	$Ysort.add_child(dump)
	# dumpsters are two wide so we need to skip a spawn node
	return i + 1

func spawnExplBarrel(dir : Vector2, i : int) -> int:
	var explbarrel : RigidBody2D = Globalpreload.EXPLBARREL_INST.duplicate()
	explbarrel.visible = true
	explbarrel.position = dir + rand_vector_variance(25)
	$Ysort.add_child(explbarrel)
	return i

func spawnItems(dir : Vector2, item_str: String, i : int) -> int:
	var item : Area2D = Globalpreload.items_instantiate.get_node(item_str).duplicate()
	if item_str == "Multi":
		if MULTI_LIST.is_empty():
			item.queue_free()
			return i
		item.item_pool = multiItemPicker()
	item.visible = true
	item.position = dir + rand_vector_variance(15)
	item.set_meta("Item", null)
	# is there a grace period so it does not get deleted imediately?
	item.explImmume = i == -999
	$Ysort.add_child(item)
	return i

func spawnShop(dir : Vector2, node_num : int, i : int) -> int:
	# we have to check if this is the last node to prevent clipping out of bounds
	if i + 1 >= node_num: return i
	var generated : Array = chooseShopItems()
	if generated[0] == null: return i
	var shop : Area2D = Globalpreload.SHOP_INST.duplicate()
	shop.visible = true
	shop.position = dir + rand_vector_variance(5)
	shop.priceItemName = generated[0]
	shop.productItemName = generated[1]
	shop.pricenum = generated[2]
	shop.productnum = generated[3]
	shop.priceItem = chooseShopDealTextures(generated[0])
	shop.productItem = chooseShopDealTextures(generated[1])
	shop.position.y -= Global.player_height_px
	$Ysort.add_child(shop)
	# shops are two wide so we need to skip a spawn node
	return i + 1

func spawnDeal(dir : Vector2, node_num : int, i : int) -> int:
	# we have to check if this is the last node to prevent clipping out of bounds
	if i + 1 >= node_num: return i
	var generated : Array = chooseDealItems()
	if generated[0] == null: return i
	var deal : Area2D = Globalpreload.DEAL_INST.duplicate()
	deal.visible = true
	deal.position = dir + rand_vector_variance(5)
	deal.dealItemName = generated[0]
	deal.dealCurseName = generated[1]
	deal.dealnum = generated[2]
	deal.cursenum = generated[3]
	deal.dealItem = chooseShopDealTextures(generated[0])
	deal.dealCurse = chooseShopDealTextures(generated[1])
	deal.position.y -= Global.player_height_px
	$Ysort.add_child(deal)
	# shops are two wide so we need to skip a spawn node
	return i + 1

func chooseShopItemTiers() -> Array:
	var chosenTierIndex : int = GRand.maprand.rand_weighted(shopitemtierchances)
	var chosenTier : String = shopitemtier[chosenTierIndex]
	return [itemtierinventory[chosenTier][0], itemtierinventory[chosenTier][1], 
	itemtierprices[chosenTier], chosenTierIndex]
	
func chooseShopItems() -> Array:
	if shop_is_closed: return [null]
	
	var chosenArray : Array = chooseShopItemTiers()
	var chosenInputArray : Array = chosenArray[0]
	var chosenOutputArray : Array = chosenArray[1]
	var chosenInput : String = ""
	var chosenOutput : String = ""

	chosenInput = chosenInputArray[GRand.maprand.randi() % chosenInputArray.size()]
	var arraytemp : Array = chosenOutputArray.duplicate(true)
	arraytemp.erase(chosenInput)
	
	if arraytemp.is_empty():
		shopitemtier.remove_at(chosenArray[3])
		shopitemtierchances.remove_at(chosenArray[3])
		if shopitemtierchances.is_empty(): shop_is_closed = true
		return [null]
	
	chosenOutput = arraytemp[GRand.maprand.randi() % arraytemp.size()]
	
	var shop_cost : int = floor(abs(GRand.maprand.randfn(
		chosenArray[2][0], chosenArray[2][1])) + 1)
	if shop_cost > 99: shop_cost = 99
	var shop_reward_num : int = floor(abs(GRand.maprand.randfn(
		chosenArray[2][2], chosenArray[2][3])) + 1)
	if shop_reward_num > 99: shop_reward_num = 99
	
	# this serves to make early game shops actually usable (maybe)
	if Global.score < 50: shop_cost = 1
	
	return [chosenInput, chosenOutput, shop_cost, shop_reward_num]

func chooseDealItems() -> Array:
	if deal_is_closed: return [null]
	var chosenTierIndex : int = GRand.maprand.rand_weighted(itemtierdealchances)
	var chosenDealTier : String = itemtierdeal[chosenTierIndex]
	var chosenDealArray : Array = itemtierdict["dealitems"][chosenDealTier]
	var chosenItem : String = chosenDealArray[GRand.maprand.randi() % chosenDealArray.size()]
	var chosenCurse : String = itemtierdict["dealcurses"]["c"]\
	[GRand.maprand.randi() % itemtierdict["dealcurses"]["c"].size()]

	var deal_item_num : int = floor(abs(GRand.maprand.randfn(
		dealtierprices[chosenDealTier][0], dealtierprices[chosenDealTier][1])) + 1)
	if deal_item_num > 99: deal_item_num = 99
	var deal_curse_num  : int = floor(abs(GRand.maprand.randfn(
		dealtierprices[chosenDealTier][2], dealtierprices[chosenDealTier][3])) + 1)
	if deal_curse_num > 99: deal_curse_num = 99

	return [chosenItem, chosenCurse, deal_item_num, deal_curse_num]

func chooseShopDealTextures(shopstr: String) -> Texture2D:
	match shopstr:
		"None": return null
		"PlayerSpeedShop", "PlayerSpeedDeal": return playerspeedglowicon
		"GlideBootsShop", "GlideBootsDeal": return glideglowicon
		"DashShop", "DashDeal": return dashglowicon
		"expl_BShop", "expl_BDeal": return expl_B_glowicon
		"GrappleShop", "GrappleDeal": return grapple_glowicon
		"ShieldShop", "ShieldDeal": return shield_glowicon
		"GambaShop", "GambaDeal": return gamba_glowicon
		"FollowerShop", "FollowerDeal": return follower_glowicon
		"ShrinkShop", "ShrinkDeal": return shrink_glowicon
		"SlowShop", "SlowDeal": return slow_glowicon
		"GrowShop", "GrowDeal": return grow_glowicon
		"TeleportShop", "TeleportDeal": return tele_glowicon
		"ItemTeleportShop", "ItemTeleportDeal": return itemtele_glowicon
		"CleanseShop", "CleanseDeal": return cleanse_glowicon
		"DVDBounceShop", "DVDBounceDeal": return dvdbounce_glowicon
		"HoleShop", "HoleDeal": return hole_glowicon
		_: 
			print("This randomly selected Shop/Deal String does not exist!:", shopstr)
			return null

func carSpawn() -> void:
	var car : Node2D = Globalpreload.CAR_INST.duplicate()
	car.position.y = $spawnterrain/Node0.global_position.y - 5
	car.visible = true
	
	var side : int = GRand.maprand.randi_range(0,1)
	if side == 0:
		car.position.x = Global.despawn_left
	else:
		car.position.x = Global.despawn_right
		
	$Ysort.add_child(car)

func spawnHole(dir : Vector2, i : int) -> int:
	var hole : Area2D = Globalpreload.HOLE_INST.duplicate()
	hole.visible = true
	hole.position = dir + rand_vector_variance(25)
	hole.position.y -= Global.player_height_px
	$Ysort.add_child(hole)
	return i

func firstTerrainSpawn(xpos : float, ypos : float) -> void:
	sidewalk = true
	var tile = Globalpreload.TILES_INST.get_node("TileMap0").duplicate()
	tile.position.x = xpos
	tile.position.y = ypos
	tile.visible = true
	TERRAIN.append(tile) 
	$spawnterrain.global_position.y -= 144
	Global.tiles_spawned += 1
	tile.set_meta("TILE_ID", Global.tiles_spawned)
	$Tiles.add_child(tile)

func terrainSpawn(type : int, xpos : float, ypos : float) -> void:
#	var tile_num = randi_range(0,1)
	if type == 0:
		sidewalk = true
	else:
		sidewalk = false
		
	var tile = Globalpreload.TILES_INST.get_node("TileMap" + str(type)).duplicate()
	tile.position.x = xpos
	tile.position.y = ypos
	tile.visible = true
	Global.tiles_spawned += 1
	tile.set_meta("TILE_ID", Global.tiles_spawned)
	TERRAIN.append(tile)
	
	$Tiles.add_child(tile)
	# item or car spawn
	if type == 0:
		objectSpawn()
	elif type == 1:
		carSpawn()
		spawnStreetObjects()
	
	$spawnterrain.global_position.y -= 144

@warning_ignore("unused_parameter")
func _input(event):
	#if event.is_action_pressed("down_s")\
	#|| event.is_action_pressed("up_w")\
	#|| event.is_action_pressed("left_a")\
	#|| event.is_action_pressed("right_d"):
		#Global.input_active = true
	#elif event.is_action_released("down_s")\
	#|| event.is_action_released("up_w")\
	#|| event.is_action_released("left_a")\
	#|| event.is_action_released("right_d"):
		#Global.input_active = false
		
	#if event.is_action_pressed("dash"):
		##Global.inc_Shrink(1)
		#Global.inc_Follower(5)
		#Global.cleanse_curse(1)
	#if event.is_action_pressed("rope"):
		##gamba_picker.begin_gamba()
		##print("test")
		##create_follower()
		##Global.inc_PlayerSlow(20)
		##Global.inc_Grow(20)
		##Global.inc_Shrink(20)
		##Global.inc_PlayerSpeed(20)
		##Global.inc_ShortTele(20)
		##Global.inc_DVD(20)
		##Global.inc_GlideBoots(20)
		##Global.inc_Dash(20)
		###Global.inc_Gamba(1)
		#Global.inc_Follower(-5)
	pass

func terrainSpawnLogic(times : int) -> void:
	for i in range(times):
		if sidewalk:
			terrainSpawn(1, 0, $spawnterrain.global_position.y)
		else:
			var tile_num = GRand.maprand.randi_range(0,1)
			terrainSpawn(tile_num, 0, $spawnterrain.global_position.y)
			
	#	print(TERRAIN[0].global_position.y)
	#	print(Global.player_pos_y)
		if !TERRAIN.is_empty() && TERRAIN[0].global_position.y - Global.player_pos_y > Global.despawn_lower:
			TERRAIN[0].queue_free()
			TERRAIN.remove_at(0)

func update_labels() -> void:
	if Global.updatelabels:
		Global.updatelabels = false
		# unfortunately this cannot be elif anymore
		# In the case that 2+ items are picked up at once
		# we need to check each one.
		controls_tooltip.show_controls()
		var label_children : Array[Node] = hboxlabels.get_children()
		if Global.playerspeedlabelon:
			if Global.player_speed_mod == 0:
				hboxlabels.remove_child(playerspeedicon)
			elif playerspeedicon not in label_children:
				hboxlabels.add_child(playerspeedicon)
			Global.playerspeedlabelon = false
			playerspeedicon.get_node("PlayerSpeed").text = str(Global.player_speed_mod)
		if  Global.glidelabelon:
			if Global.glide_mod == 0:
				hboxlabels.remove_child(glideicon)
			elif glideicon not in label_children:
				hboxlabels.add_child(glideicon)
			Global.glidelabelon = false
			glideicon.get_node("Glide").text = str(Global.glide_mod)
		if Global.dashlabelon:
			if Global.dash_mod == 0:
				hboxlabels.remove_child(dashicon)
			elif dashicon not in label_children:
				hboxlabels.add_child(dashicon)
			Global.dashlabelon = false
			dashicon.get_node("Dash").text = str(Global.dash_mod)
		if Global.expl_B_labelon:
			if Global.expl_B_mod == 0:
				hboxlabels.remove_child(expl_B_icon)
			elif expl_B_icon not in label_children:
				hboxlabels.add_child(expl_B_icon)
			Global.expl_B_labelon = false
			expl_B_icon.get_node("expl_B").text = str(Global.expl_B_mod)
		if Global.grapplelabelon:
			if Global.grapple_mod == 0:
				hboxlabels.remove_child(grapple_icon)
				Global.follower_array[0].disable_itemgrapple()
			elif grapple_icon not in label_children:
				hboxlabels.add_child(grapple_icon)
				Global.follower_array[0].enable_itemgrapple()
			Global.grapplelabelon = false
			grapple_icon.get_node("Grapple").text = str(Global.grapple_mod)
		if Global.followerlabelon:
			if Global.follower_mod == Global.follower_mod_base:
				hboxlabels.remove_child(follower_icon)
			elif follower_icon not in label_children:
				hboxlabels.add_child(follower_icon)
			Global.followerlabelon = false
			follower_icon.get_node("Follower").text = str(Global.follower_mod - Global.follower_mod_base)
		if Global.shrinklabelon:
			if Global.shrink_mod == 0:
				hboxlabels.remove_child(shrink_icon)
			elif shrink_icon not in label_children:
				hboxlabels.add_child(shrink_icon)
			Global.shrinklabelon = false
			shrink_icon.get_node("Shrink").text = str(Global.shrink_mod)
		if Global.playerslowlabelon:
			if Global.playerslow_mod == Global.playerslow_mod_base:
				hboxlabels.remove_child(slow_icon)
			elif slow_icon not in label_children:
				hboxlabels.add_child(slow_icon)
			Global.playerslowlabelon = false
			slow_icon.get_node("Slow").text = str(Global.playerslow_mod - Global.playerslow_mod_base)
		if Global.growlabelon:
			if Global.grow_mod == 0:
				hboxlabels.remove_child(grow_icon)
			elif grow_icon not in label_children:
				hboxlabels.add_child(grow_icon)
			Global.growlabelon = false
			grow_icon.get_node("Grow").text = str(Global.grow_mod)
		if Global.telelabelon:
			if Global.tele_mod == 0:
				hboxlabels.remove_child(tele_icon)
			elif tele_icon not in label_children:
				hboxlabels.add_child(tele_icon)
			Global.telelabelon = false
			tele_icon.get_node("Teleport").text = str(Global.tele_mod)
		if Global.itemtelelabelon:
			if Global.itemtele_mod == 0:
				hboxlabels.remove_child(itemtele_icon)
			elif itemtele_icon not in label_children:
				hboxlabels.add_child(itemtele_icon)
			Global.itemtelelabelon = false
			itemtele_icon.get_node("ItemTeleport").text = str(Global.itemtele_mod)
		if Global.dvdbouncelabelon:
			if Global.dvd_mod == 0:
				hboxlabels.remove_child(dvdbounce_icon)
			elif dvdbounce_icon not in label_children:
				hboxlabels.add_child(dvdbounce_icon)
			Global.dvdbouncelabelon = false
			dvdbounce_icon.get_node("DVDBounce").text = str(Global.dvd_mod)
		if Global.holelabelon:
			if Global.hole_mod == 0:
				hboxlabels.remove_child(hole_icon)
			elif hole_icon not in label_children:
				hboxlabels.add_child(hole_icon)
			Global.holelabelon = false
			hole_icon.get_node("Hole").text = str(Global.hole_mod)

func dash_check() -> void:
	if Global.dash && dashpopup: 
		dashpopup = false
		var dash_pop_up : Control = Globalpreload.POP_INST.duplicate()
		$CanvasLayer.add_child(dash_pop_up)

func speed_run_check() -> void:
	if Global.sandbox || Global.challenge: return
	var newtime : bool = false
	var checkpoint := speed_run_checkpoints.keys()
	for i in checkpoint:
		if Global.score >= i && (Global.stopwatch_time < \
		SettingsDataContainer.get_speedrun_dict_type("speedrun_" + str(i)) || \
		SettingsDataContainer.get_speedrun_dict_type("speedrun_" + str(i)) == 0):
			speed_run_checkpoints.erase(i)
			SettingsSignalBus.emit_on_speedrun_dict_set(
				"speedrun_" + str(i), Global.stopwatch_time)
			newtime = true
	if newtime:
		SettingsSignalBus.emit_set_settings_dictionary(SettingsDataContainer.create_storage_dictionary())
		
func terrain_check() -> void:
	if Global.spawnTerrain:
		if Global.race_condition_tiles.is_empty(): return
		
		var max_tile_int : int = Global.race_condition_tiles.max()

		Global.race_condition_tiles.clear()
		var score_diff : int = max_tile_int - Global.score  
		if score_diff > -1:
			Global.score = max_tile_int
			speed_run_check()
			if (Global.finish_line_tile && !high_score_reached) && \
			((Global.challenge && max_tile_int > SettingsDataContainer.get_challenges_high_score(Global.challenge_curr)) \
			|| max_tile_int > SettingsDataContainer.get_high_score()):
				high_score_reached = true
				highscore_notif()
		
		$CanvasLayer/Score.text = "Score " + str(Global.score)
		Global.spawnTerrain = false
		terrainSpawnLogic(score_diff)
		Global.incrementDifficulty(2, score_diff * 0.5)
		if Global.score % 100 == 0 || score_diff > -1:
			spawnBorder(960, Global.player_pos_y)

func spawnBorder(x : float, y : float) -> void:
	var border : Node2D = Globalpreload.BORDER_INST.duplicate()
	border.position.x = x
	border.position.y = y
#	print(border.global_position)
	BORDERS.append(border)
	$border.add_child(border)
	if BORDERS.size() > 1:
		BORDERS[0].queue_free()
		BORDERS.remove_at(0)

func spawnLineOfDeath() -> void:
	line = Globalpreload.DEATHLINE_INST.duplicate()
	line.position.x = 0
	line.position.y = 1500
	$lineofdeath.add_child(line)
	Global.game_line = line

func loadDefeat() -> void:
	losepopup = Globalpreload.DEFEAT_INST.duplicate()
	losepopup.visible = false
	$CanvasLayer.add_child(losepopup)
	Global.game_over_pop_up = losepopup

func loadPause() -> void:
	pausepopup = Globalpreload.PAUSE_INST.duplicate()
	pausepopup.visible = false
	$CanvasLayer.add_child(pausepopup)
	Global.pause_popup = pausepopup

func spawn_high_score_line() -> void:
	if Global.sandbox: return
	var high_score : int
	if Global.challenge:
		high_score = SettingsDataContainer.get_challenges_high_score(
			Global.challenge_curr)
	else:
		high_score = SettingsDataContainer.get_high_score()
	# don't spawn line too close
	if high_score < 10:
		if is_instance_valid(Global.finish_line_tile):
			Global.finish_line_tile.free()
		else:
			Global.finish_line_tile = null
		return
	
	var high_score_dist : int = (high_score * -144) + 936
	var high_score_line : Node2D = Globalpreload.CHECKERDLINE.instantiate()
	high_score_line.position.x = 0
	high_score_line.position.y = high_score_dist
	Global.finish_line_tile = high_score_line
	$lineofdeath.add_child(high_score_line)

func load_gamba_picker() -> void:
	gamba_picker = Globalpreload.GAMBAPICKER.instantiate()
	gamba_picker.good_item_pool = gamba_array_good
	gamba_picker.bad_item_pool = gamba_array_bad
	gamba_picker.gamba_result_time_seconds = 3
	$CanvasLayer.add_child(gamba_picker)

func gamba_check() -> void:
	if Global.gamba_update:
		Global.gamba_update = false
		Global.gamba_running = true
		gamba_picker.begin_gamba()

func create_follower() -> void:
	for i in range(Global.follower_spawn_multi):
		var follower : RigidBody2D = Globalpreload.follower_basic.duplicate()
		var follower_in_front : RigidBody2D = Global.follower_array[-1]
		follower.set_script(Globalpreload.FOLLOWERSCRIPT)
		follower.set_meta("Follower", curr_follower_id)
		follower.get_node("Camera2D").queue_free()
		follower.get_node("follower_cleanup_timer").queue_free()
		follower.get_node("AutoItemGrapple").queue_free()
		follower.get_node("AutoItemGrapple").queue_free()
		follower.get_node("AnimationPlayer").queue_free()
		follower.get_node("CollisionReveal").visible = false
		follower.get_node("FeetCollisionRevealMarker2D").visible = false
		follower.remove_meta("Player")
		curr_follower_id += 1
		#follower.set_collision_layer_value(1, false)
		
		var timer : Timer = Timer.new()
		timer.autostart = true
		timer.wait_time = 0.05
		timer.timeout.connect(follower._on_timer_timeout)
		follower.add_child(timer)
		
		var follower_in_front_pos : Vector2 = follower_in_front.get_node(
			"BotCollisionPolygon2D2/followerspawn").global_position
		follower.position = follower_in_front_pos
		
		follower.get_node("TopCollisionPolygon2D").scale = follower_in_front.get_node("TopCollisionPolygon2D").scale
		follower.get_node("BotCollisionPolygon2D2").scale = follower_in_front.get_node("BotCollisionPolygon2D2").scale
		follower.get_node("playermove").scale = follower_in_front.get_node("playermove").scale
		follower.get_node("shield").scale = follower_in_front.get_node("shield").scale
		follower.get_node("GlideBoots").scale = follower_in_front.get_node("GlideBoots").scale
		follower.get_node("FollowerCollision").scale = follower_in_front.get_node("FollowerCollision").scale
		follower.get_node("feet").scale = follower_in_front.get_node("feet").scale
		
		follower.modulate = Color(1,1,2)
		
		Global.follower_array.append(follower)
		$Ysort.add_child(follower)
	
	Global.follower_spawn_multi = Global.follower_spawn_multi_base

func follower_check() ->void:
	if Global.Follower:
		Global.Follower = false
		create_follower()

func highscore_notif() -> void:
	if Global.sandbox: return
	var high_score_pop_up : Control = Globalpreload.POP_INST.duplicate()
	high_score_pop_up.get_node("dashpopup/Label").text = "New High Score!"
	canvas_layer.add_child(high_score_pop_up)
	Global.finish_line_tile.queue_free()

func spawn_dvd_bounce_area() -> void:
	canvas_layer.get_node("DVDbouncelayer").add_child(DVDarea)

func dvd_bounce_check() -> void:
	if Global.dvd_spawn:
		Global.dvd_spawn = false
		for i in range(Global.dvd_spawn_num):
			var DVDnodetemp : RigidBody2D = Globalpreload.DVDnode.duplicate()
			DVDnodetemp.sleeping = false
			DVDnodetemp.visible = true
			DVDnodetemp.position = Vector2(GRand.maprand.randf_range(100, 1820), 
			GRand.maprand.randf_range(100, 980))
			DVDnodetemp.velocity = Vector2(250, 250).rotated(
				deg_to_rad(GRand.maprand.randf_range(0,360)))
			DVDarea.get_node("DVDnodes").add_child(DVDnodetemp)
			Global.dvd_array.append(DVDnodetemp)
		Global.dvd_spawn_num = 0
