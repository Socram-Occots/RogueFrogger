class_name PlayerKeybindResource
extends Resource

const MOVE_UP : String = "up_w"
const MOVE_DOWN : String = "down_s"
const MOVE_RIGHT : String = "right_d"
const MOVE_LEFT : String = "left_a"
const MOVE_DASH : String = "dash"
const MOVE_WALK : String = "walk"
const MOVE_ROPE : String = "rope"
const MOVE_GLIDE : String = "glide"

const CONTROLLER_UP_STICK : String = "up_cont_stick"
const CONTROLLER_DOWN_STICK : String = "down_cont_stick"
const CONTROLLER_RIGHT_STICK : String = "right_cont_stick"
const CONTROLLER_LEFT_STICK : String = "left_cont_stick"
const CONTROLLER_UP_BUTTON : String = "up_cont_button"
const CONTROLLER_DOWN_BUTTON : String = "down_cont_button"
const CONTROLLER_RIGHT_BUTTON : String = "right_cont_button"
const CONTROLLER_LEFT_BUTTON : String = "left_cont_button"
const CONTROLLER_DASH : String = "dash_cont"
const CONTROLLER_WALK : String = "walk_cont"
const CONTROLLER_ROPE : String = "rope_cont"
const CONTROLLER_GLIDE : String = "glide_cont"
const CONTROLLER_AIM_UP_STICK : String = "up_cont_aim_stick"
const CONTROLLER_AIM_DOWN_STICK : String = "down_cont_aim_stick"
const CONTROLLER_AIM_RIGHT_STICK : String = "right_cont_aim_stick"
const CONTROLLER_AIM_LEFT_STICK : String = "left_cont_aim_stick"


@export var DEFAULT_MOVE_UP_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_DOWN_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_RIGHT_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_LEFT_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_DASH_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_WALK_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_ROPE_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_GLIDE_KEY = InputEventKey.new()

@export var DEFAULT_CONTROLLER_UP_STICK = InputEventJoypadMotion.new()
@export var DEFAULT_CONTROLLER_DOWN_STICK = InputEventJoypadMotion.new()
@export var DEFAULT_CONTROLLER_RIGHT_STICK = InputEventJoypadMotion.new()
@export var DEFAULT_CONTROLLER_LEFT_STICK = InputEventJoypadMotion.new()
@export var DEFAULT_CONTROLLER_UP_BUTTON = InputEventJoypadButton.new()
@export var DEFAULT_CONTROLLER_DOWN_BUTTON = InputEventJoypadButton.new()
@export var DEFAULT_CONTROLLER_RIGHT_BUTTON = InputEventJoypadButton.new()
@export var DEFAULT_CONTROLLER_LEFT_BUTTON = InputEventJoypadButton.new()
@export var DEFAULT_CONTROLLER_DASH = InputEventJoypadButton.new()
@export var DEFAULT_CONTROLLER_WALK = InputEventJoypadButton.new()
@export var DEFAULT_CONTROLLER_ROPE = InputEventJoypadButton.new()
@export var DEFAULT_CONTROLLER_GLIDE = InputEventJoypadButton.new()
@export var DEFAULT_CONTROLLER_AIM_UP_STICK = InputEventJoypadMotion.new()
@export var DEFAULT_CONTROLLER_AIM_DOWN_STICK = InputEventJoypadMotion.new()
@export var DEFAULT_CONTROLLER_AIM_RIGHT_STICK = InputEventJoypadMotion.new()
@export var DEFAULT_CONTROLLER_AIM_LEFT_STICK = InputEventJoypadMotion.new()

var move_up_key
var move_down_key
var move_right_key
var move_left_key
var move_dash_key
var move_walk_key
var move_rope_key
var move_glide_key

var controller_up_stick
var controller_down_stick
var controller_right_stick
var controller_left_stick
var controller_up_button
var controller_down_button
var controller_right_button
var controller_left_button
var controller_dash 
var controller_walk 
var controller_rope
var controller_glide
var controller_aim_up_stick
var controller_aim_down_stick
var controller_aim_right_stick
var controller_aim_left_stick
