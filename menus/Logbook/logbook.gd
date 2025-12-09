extends Control
@onready var tab_container: TabContainer = $MarginContainer/VBoxContainer/LogbookTabs/TabContainer

func _ready():
	tab_container.current_tab = 0
	add_to_group("UI_FOCUS", true)
	begin_focus()

func _on_exit_and_save_pressed() -> void:
	SettingsSignalBus.emit_set_settings_dictionary(SettingsDataContainer.create_storage_dictionary())
	get_tree().change_scene_to_file("res://menus/startscreen.tscn")

func begin_focus() -> void:
	if visible:
		tab_container.get_tab_bar().grab_focus()
