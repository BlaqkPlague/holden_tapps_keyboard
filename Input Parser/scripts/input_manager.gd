@icon("res://assets/game-controller-outline.svg")
class_name InputManager

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

var urdl_vector: Vector2 = Vector2.ZERO
var nesw_vector: Vector2 = Vector2.ZERO
var prev_urdl_vector: Vector2 = Vector2.ZERO
var prev_nesw_vector: Vector2 = Vector2.ZERO
var left_stick_vector: Vector2 = Vector2.ZERO
var right_stick_vector: Vector2 = Vector2.ZERO
var prev_left_stick_vector: Vector2 = Vector2.ZERO
var prev_right_stick_vector: Vector2 = Vector2.ZERO


var left_angle: int = 0
var right_angle: int = 0
var prev_left_angle: int = 0
var prev_right_angle: int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	prints ("Input Manager ready", Time.get_ticks_msec())

	pass # Replace with function body.


func _input(_event):
#	Cache previous inputs.
	prev_left_angle = left_angle
	prev_urdl_vector = urdl_vector
	prev_left_stick_vector = left_stick_vector

	prev_right_angle = right_angle
	prev_nesw_vector = nesw_vector
	prev_right_stick_vector = right_stick_vector

#	Lookup and store D-Pad input and L.Stick input as 0 through 8.
	left_stick_vector = Vector2()
	left_stick_vector.x =  int(Input.is_action_pressed("p1_leftstick_right")) - int(Input.is_action_pressed("p1_leftstick_left"))
	left_stick_vector.y =  int(Input.is_action_pressed("p1_leftstick_down")) - int(Input.is_action_pressed("p1_leftstick_up"))
	
	if left_stick_vector != prev_left_stick_vector:
		left_angle = ANGLE_ENCODER_LOOKUP[left_stick_vector.y+1][left_stick_vector.x+1]
	
	urdl_vector = Vector2(
		Input.get_axis("p1_dpad_left","p1_dpad_right"), 
		Input.get_axis("p1_dpad_up","p1_dpad_down")
	)
	if urdl_vector != prev_urdl_vector:
		left_angle = ANGLE_ENCODER_LOOKUP[urdl_vector.y+1][urdl_vector.x+1]
	
	
	right_stick_vector = Vector2()
	right_stick_vector.x =  int(Input.is_action_pressed("p1_rightstick_east")) - int(Input.is_action_pressed("p1_rightstick_west"))
	right_stick_vector.y =  int(Input.is_action_pressed("p1_rightstick_south")) - int(Input.is_action_pressed("p1_rightstick_north"))
	
	if right_stick_vector != prev_right_stick_vector:
		right_angle = ANGLE_ENCODER_LOOKUP[right_stick_vector.y+1][right_stick_vector.x+1]
		
	nesw_vector = Vector2(
		Input.get_axis("p1_nesw_west","p1_nesw_east"), 
		Input.get_axis("p1_nesw_north","p1_nesw_south")
	)
	if nesw_vector != prev_nesw_vector:
		right_angle = ANGLE_ENCODER_LOOKUP[nesw_vector.y+1][nesw_vector.x+1]
	
	
	if left_angle != prev_left_angle or right_angle != prev_right_angle:
		SignalBus.inputs_changed.emit(left_angle, right_angle, Time.get_ticks_msec())
