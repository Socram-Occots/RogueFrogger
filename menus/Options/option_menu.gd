extends Control

@onready var tab_path = $MarginContainer/VBoxContainer/Settings_Tabs/TabContainer

func _on_visibility_changed():
	if visible:
		$AnimationPlayer.play("startpause")

func _ready():
	tab_path.set_tab_hidden(0, true)
	tab_path.current_tab = 1

func _on_exit_pressed():
	SettingsSignalBus.emit_set_settings_dictionary(SettingsDataContainer.create_storage_dictionary())
	Global.options_down()
