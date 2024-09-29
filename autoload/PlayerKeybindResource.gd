class_name PlayerKeybindResource
extends Resource

const MOVE_UP : String = "up_w"
const MOVE_DOWN : String = "down_s"
const MOVE_RIGHT : String = "right_d"
const MOVE_LEFT : String = "left_a"
const MOVE_DASH : String = "dash"
const MOVE_WALK : String = "walk"

@export var DEFAULT_MOVE_UP_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_DOWN_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_RIGHT_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_LEFT_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_DASH_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_WALK_KEY = InputEventKey.new()

var move_up_key = InputEventKey.new()
var move_down_key = InputEventKey.new()
var move_right_key = InputEventKey.new()
var move_left_key = InputEventKey.new()
var move_dash_key = InputEventKey.new()
var move_walk_key = InputEventKey.new()
