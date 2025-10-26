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

const CONTROLLER_UP : String = "up_cont"
const CONTROLLER_DOWN : String = "down_cont"
const CONTROLLER_RIGHT : String = "right_cont"
const CONTROLLER_LEFT : String = "left_cont"
const CONTROLLER_DASH : String = "dash_cont"
const CONTROLLER_WALK : String = "walk_cont"
const CONTROLLER_ROPE : String = "rope_cont"
const CONTROLLER_GLIDE : String = "glide_cont"


@export var DEFAULT_MOVE_UP_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_DOWN_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_RIGHT_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_LEFT_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_DASH_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_WALK_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_ROPE_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_GLIDE_KEY = InputEventKey.new()

@export var DEFAULT_CONTROLLER_UP = InputEventKey.new()
@export var DEFAULT_CONTROLLER_DOWN = InputEventKey.new()
@export var DEFAULT_CONTROLLER_RIGHT = InputEventKey.new()
@export var DEFAULT_CONTROLLER_LEFT = InputEventKey.new()
@export var DEFAULT_CONTROLLER_DASH = InputEventKey.new()
@export var DEFAULT_CONTROLLER_WALK = InputEventKey.new()
@export var DEFAULT_CONTROLLER_ROPE = InputEventKey.new()
@export var DEFAULT_CONTROLLER_GLIDE = InputEventKey.new()

var move_up_key = InputEventKey.new()
var move_down_key = InputEventKey.new()
var move_right_key = InputEventKey.new()
var move_left_key = InputEventKey.new()
var move_dash_key = InputEventKey.new()
var move_walk_key = InputEventKey.new()
var move_rope_key = InputEventKey.new()
var move_glide_key = InputEventKey.new()

var controller_up = InputEventKey.new()
var controller_down = InputEventKey.new()
var controller_right = InputEventKey.new()
var controller_left = InputEventKey.new()
var controller_dash = InputEventKey.new()
var controller_walk = InputEventKey.new()
var controller_rope = InputEventKey.new()
var controller_glide = InputEventKey.new()
