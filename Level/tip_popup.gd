extends VBoxContainer
@onready var title: Label = $TipPopupTitle/Label
@onready var description: Label = $TipPopupText/Label
@onready var texture_rect: TextureRect = $TextureRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var queue : Array[Array] = []
@onready var displaying : bool = false
@onready var reverse : bool = false
@onready var tip_popup_key: HBoxContainer = $TipPopupKey
@onready var tipkeyrect: TextureRect = $TipPopupKey/TextureRect2
@onready var keyicon : ControllerIconTexture = ControllerIconTexture.new()


func _ready() -> void:
	visible = false

func displayTip(popuparray : Array) -> void:
	visible = true
	title.text = popuparray[0]
	description.text = SettingsDataContainer.get_logbook_dict_popuptooltip(popuparray[1], popuparray[0])
	var keystring : String =  get_icon_string(popuparray[0])
	if keystring != "None":
		tip_popup_key.visible = true
		keyicon.path = keystring
		tipkeyrect.texture = keyicon
	else:
		tip_popup_key.visible = false
	displaying = true
	set_texture(Global.get_texture_icons(popuparray[0], "ToolTipPopup"))
	reverse = false
	animation_player.play("popup")
	await get_tree().create_timer(4).timeout
	reverse = true
	animation_player.play_backwards("popup")
	
func loadTip(titleStr : String, typestr : String) -> void:
	queue.append([titleStr, typestr])
	if !displaying:
		displayTip(queue[0])
		
func set_texture(texture) -> void:
	texture_rect.texture = texture

func get_icon_string(titlestr : String) -> String:
	var temparr : Array[String] = ["None","None"]
	match titlestr:
		"GlideBoots" : 
			temparr[0] = "glide"
			temparr[1] = "glide_cont"
		"Dash" :  
			temparr[0] = "dash"
			temparr[1] = "dash_cont"
		"Grapple" : 
			temparr[0] = "rope"
			temparr[1] = "rope_cont"
		"ExplBarrel" : 
			temparr[0] = "throw"
			temparr[1] = "throw_cont"
	if Global.using_cont: return temparr[1]
	return temparr[0]
	
@warning_ignore("unused_parameter")
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if reverse:
		displaying = false
		visible = false
		queue.pop_front()
		if !queue.is_empty():
			displayTip(queue[0])
