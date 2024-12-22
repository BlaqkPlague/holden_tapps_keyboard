@icon("res://assets/game-controller-outline.svg")
class_name InputManagerV2

extends Node

# Reads inputs from controller, and outputs signals to be handled by other nodes.


# 	TODO: Refactor into single function that iterates D-Pad, L.Stick, R.Stick, and NESW Buttons.
# 	TODO: Create signals for all events. 
# 	TODO: Separate and simultaneously broadcast all as signals. 


const ANGLE_ENCODER_LOOKUP := [
	[8,1,2],
	[7,0,3],
	[6,5,4]
]
const ARROW_LOOKUP := ["⭘", "↑", "↗", "→", "↘", " ↓ ", "↙", "←", "↖"]
enum OUTPUT_TYPE {ONE,}

var curr_keyb_left_vector: Vector2 = Vector2.ZERO
var curr_keyb_right_vector: Vector2 = Vector2.ZERO
var prev_keyb_left_vector: Vector2 = Vector2.ZERO
var prev_keyb_right_vector: Vector2 = Vector2.ZERO
var curr_mouse_left_vector: Vector2 = Vector2.ZERO
var curr_mouse_right_vector: Vector2 = Vector2.ZERO
var prev_mouse_left_vector: Vector2 = Vector2.ZERO
var prev_mouse_right_vector: Vector2 = Vector2.ZERO


var curr_left_angle: int = 0
var curr_right_angle: int = 0
var prev_left_angle: int = 0
var prev_right_angle: int = 0

# Output angles are stored / signaled as (type, angle, timestamp)

# Called when the node enters the scene tree for the first time.
func _ready():
	prints ("Input Manager ready", Time.get_ticks_msec())

	pass # Replace with function body.


func _input(_event):
#	Cache previous inputs.
	prev_left_angle = curr_left_angle
	prev_keyb_left_vector = curr_keyb_left_vector
	prev_mouse_left_vector = curr_mouse_left_vector

	prev_right_angle = curr_right_angle
	prev_keyb_right_vector = curr_keyb_right_vector
	prev_mouse_right_vector = curr_mouse_right_vector

#	Lookup and store D-Pad input and L.Stick input as 0 through 8.
	curr_mouse_left_vector = Vector2()
	curr_mouse_left_vector.x =  int(Input.is_action_pressed("p1_leftstick_right")) - int(Input.is_action_pressed("p1_leftstick_left"))
	curr_mouse_left_vector.y =  int(Input.is_action_pressed("p1_leftstick_down")) - int(Input.is_action_pressed("p1_leftstick_up"))
	
	if curr_mouse_left_vector != prev_mouse_left_vector:
		curr_left_angle = ANGLE_ENCODER_LOOKUP[curr_mouse_left_vector.y+1][curr_mouse_left_vector.x+1]
	
	curr_keyb_left_vector = Vector2(
		Input.get_axis("p1_dpad_left","p1_dpad_right"), 
		Input.get_axis("p1_dpad_up","p1_dpad_down")
	)
	if curr_keyb_left_vector != prev_keyb_left_vector:
		curr_left_angle = ANGLE_ENCODER_LOOKUP[curr_keyb_left_vector.y+1][curr_keyb_left_vector.x+1]
	
	
	curr_mouse_right_vector = Vector2()
	curr_mouse_right_vector.x =  int(Input.is_action_pressed("p1_rightstick_east")) - int(Input.is_action_pressed("p1_rightstick_west"))
	curr_mouse_right_vector.y =  int(Input.is_action_pressed("p1_rightstick_south")) - int(Input.is_action_pressed("p1_rightstick_north"))
	
	if curr_mouse_right_vector != prev_mouse_right_vector:
		curr_right_angle = ANGLE_ENCODER_LOOKUP[curr_mouse_right_vector.y+1][curr_mouse_right_vector.x+1]
		
	curr_keyb_right_vector = Vector2(
		Input.get_axis("p1_nesw_west","p1_nesw_east"), 
		Input.get_axis("p1_nesw_north","p1_nesw_south")
	)
	if curr_keyb_right_vector != prev_keyb_right_vector:
		curr_right_angle = ANGLE_ENCODER_LOOKUP[curr_keyb_right_vector.y+1][curr_keyb_right_vector.x+1]
	
	
	if curr_left_angle != prev_left_angle or curr_right_angle != prev_right_angle:
		SignalBus.inputs_changed.emit(curr_left_angle, curr_right_angle, Time.get_ticks_msec())
