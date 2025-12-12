extends VBoxContainer
@onready var texture_rect_keyRun: TextureRect = $Run/TextureRectKey
@onready var texture_rect_key_2Run: TextureRect = $Run/TextureRectKey2
@onready var texture_rect_key_3Run: TextureRect = $Run/TextureRectKey3
@onready var texture_rect_key_4Run: TextureRect = $Run/TextureRectKey4
@onready var texture_rect_contRun: TextureRect = $Run/TextureRectCont
@onready var texture_rect_keyWalk: TextureRect = $Walk/TextureRectKey
@onready var texture_rect_contWalk: TextureRect = $Walk/TextureRectCont
@onready var texture_rect_keyDash: TextureRect = $Dash/TextureRectKey
@onready var texture_rect_contDash: TextureRect = $Dash/TextureRectCont
@onready var texture_rect_keyGlide: TextureRect = $Glide/TextureRectKey
@onready var texture_rect_contGlide: TextureRect = $Glide/TextureRectCont
@onready var texture_rect_keyGrapple: TextureRect = $Grapple/TextureRectKey
@onready var texture_rect_contGrapple: TextureRect = $Grapple/TextureRectCont
@onready var texture_rect_keyThrow: TextureRect = $Throw/TextureRectKey
@onready var texture_rect_contThrow: TextureRect = $Throw/TextureRectCont
@onready var dashlabel: Label = $Dash/Label
@onready var glidelabel: Label = $Glide/Label
@onready var grapplelabel: Label = $Grapple/Label
@onready var throwlabel: Label = $Throw/Label

@onready var cont_mode : bool = false

func _ready() -> void:
	show_controls()

func show_controls() -> void:
	if Global.using_cont:
		show_controller_controls()
	else:
		show_key_controls()
	show_labels()

func show_labels() -> void:
	dashlabel.visible = texture_rect_keyDash.visible || texture_rect_contDash.visible
	glidelabel.visible = texture_rect_keyGlide.visible || texture_rect_contGlide.visible
	grapplelabel.visible = texture_rect_keyGrapple.visible || texture_rect_contGrapple.visible
	throwlabel.visible = texture_rect_keyThrow.visible || texture_rect_contThrow.visible
	
func show_key_controls() -> void:
	texture_rect_keyRun.visible = true
	texture_rect_key_2Run.visible = true
	texture_rect_key_3Run.visible = true
	texture_rect_key_4Run.visible = true
	texture_rect_keyWalk.visible = true
	texture_rect_keyDash.visible = Global.dash_mod > 0
	texture_rect_keyGlide.visible = Global.glide_mod > 0
	texture_rect_keyGrapple.visible = Global.grapple_mod > 0
	if Global.follower_array.size() > 0:
		texture_rect_keyThrow.visible = Global.follower_array[0].carrying
	else:
		texture_rect_keyThrow.visible = false
	
	texture_rect_contRun.visible = false
	texture_rect_contWalk.visible = false
	texture_rect_contDash.visible = false
	texture_rect_contGlide.visible = false
	texture_rect_contGrapple.visible = false
	texture_rect_contThrow.visible = false

func show_controller_controls() -> void:
	texture_rect_contRun.visible = true
	texture_rect_contWalk.visible = true
	texture_rect_contDash.visible = Global.dash_mod > 0
	texture_rect_contGlide.visible = Global.glide_mod > 0
	texture_rect_contGrapple.visible = Global.grapple_mod > 0
	if Global.follower_array.size() > 0:
		texture_rect_contThrow.visible = Global.follower_array[0].carrying
	else:
		texture_rect_contThrow.visible = false

	texture_rect_keyRun.visible = false
	texture_rect_key_2Run.visible = false
	texture_rect_key_3Run.visible = false
	texture_rect_key_4Run.visible = false
	texture_rect_keyWalk.visible = false
	texture_rect_keyDash.visible = false
	texture_rect_keyGlide.visible = false
	texture_rect_keyGrapple.visible = false
	texture_rect_keyThrow.visible = false
