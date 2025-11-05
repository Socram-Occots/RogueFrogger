extends Control
@onready var tab_container: TabContainer = $MarginContainer/VBoxContainer/SandboxTabs/TabContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	tab_container.current_tab = 0
	add_to_group("UI_FOCUS", true)
	begin_focus()

func begin_focus() -> void:
	if visible:
		tab_container.get_tab_bar().grab_focus()

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/startscreen.tscn")

func _on_reset_tab_pressed() -> void:
	get_tree().call_group("tab" + str(tab_container.current_tab), "reset_value")

func _on_save_pressed() -> void:
	save_sandbox_settings()

func _on_save_play_pressed() -> void:
	save_sandbox_settings()
	Global.sandbox = true
	get_tree().change_scene_to_file("res://Level/level.tscn")
	
func save_sandbox_settings() -> void:
	var num_of_tabs : int = tab_container.get_children().size()
	for i in range(num_of_tabs):
		get_tree().call_group("tab" + str(i), "save_value")
	SettingsSignalBus.emit_set_settings_dictionary(SettingsDataContainer.create_storage_dictionary())
