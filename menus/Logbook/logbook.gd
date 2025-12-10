extends Control
@onready var tab_container: TabContainer = $MarginContainer/VBoxContainer/LogbookTabs/TabContainer
@onready var texture_rect: TextureRect = $VBoxContainer/TextureRect
@onready var label: Label = $VBoxContainer/HBoxContainer/Label

func _ready():
	tab_container.current_tab = 0
	add_to_group("UI_FOCUS", true)
	begin_focus()
	texture_rect.texture = null
	label.text = ""

func _on_exit_and_save_pressed() -> void:
	SettingsSignalBus.emit_set_settings_dictionary(SettingsDataContainer.create_storage_dictionary())
	get_tree().change_scene_to_file("res://menus/startscreen.tscn")

func begin_focus() -> void:
	if visible:
		tab_container.get_tab_bar().grab_focus()

func set_text_tecture(text : String, texture : Texture2D) -> void:
	label.text = text
	texture_rect.texture = texture
