extends Control

@onready var tab_path = $MarginContainer/VBoxContainer/Settings_Tabs/TabContainer
@onready var exit: Button = $MarginContainer/VBoxContainer/HBoxContainer/Exit

func _on_visibility_changed():
	if visible:
		$AnimationPlayer.play("startpause")
		begin_focus()

func begin_focus() -> void:
	if visible:
		tab_path.get_tab_bar().grab_focus()

func _ready():
	add_to_group("UI_FOCUS", true)
	tab_path.current_tab = 0

func _on_exit_pressed():
	Global.options_down()

func _on_reset_tab_pressed() -> void:
	get_tree().call_group("tab" + str(tab_path.current_tab), "reset_value")

func _on_save_pressed() -> void:
	save_sandbox_settings()

func save_sandbox_settings() -> void:
	var num_of_tabs : int = tab_path.get_children().size()
	for i in range(num_of_tabs):
		get_tree().call_group("tab" + str(i), "save_value")
	SettingsSignalBus.emit_set_settings_dictionary(SettingsDataContainer.create_storage_dictionary())
