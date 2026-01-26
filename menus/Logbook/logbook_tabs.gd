extends Control
@onready var grid_container: GridContainer = $TabContainer/Objects/MarginContainer/ScrollContainer/Margincontainer/GridContainer
@onready var objects: GridContainer = $TabContainer/Objects/MarginContainer/ScrollContainer/Margincontainer/GridContainer
@onready var items: GridContainer = $TabContainer/Items/MarginContainer/ScrollContainer/Margincontainer/GridContainer
@onready var curses: GridContainer = $TabContainer/Curses/MarginContainer/ScrollContainer/Margincontainer/GridContainer
@onready var logbook_setter: Control = $LogbookSetter
@onready var object_arr := SettingsDataContainer.get_logbook_dict_type("Objects").keys()
@onready var items_arr := SettingsDataContainer.get_logbook_dict_type("Items").keys()
@onready var curses_arr := SettingsDataContainer.get_logbook_dict_type("Curses").keys()
@onready var object_exceptions : Array[String] = ["ExplBarrelPickUpEvent"]

func _ready() -> void:
	logbook_setter.visible = false
	
	for i in object_arr:
		if !(i in object_exceptions):
			var temp : Control = logbook_setter.duplicate()
			temp.visible = true
			temp.object = i
			temp.type = "Objects"
			objects.add_child(temp)
	for i in items_arr:
		var temp : Control = logbook_setter.duplicate()
		temp.visible = true
		temp.object = i
		temp.type = "Items"
		items.add_child(temp)
	for i in curses_arr:
		var temp : Control = logbook_setter.duplicate()
		temp.visible = true
		temp.object = i
		temp.type = "Curses"
		curses.add_child(temp)
