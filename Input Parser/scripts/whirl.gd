
extends Node

var curr_rotation: int = 0
var prev_rotation: int = 0
var curr_left_rotation: int = 0
var prev_left_rotation: int = 0
var curr_right_rotation: int = 0
var prev_right_rotation: int = 0
var prev_left_angle: int = 0
var prev_right_angle: int = 0


func _ready():
	prints(Time.get_ticks_msec(), "Whirl Online.")
	SignalBus.inputs_changed.connect(_on_inputs_changed)

# Accepts inputs_changed signal and broadcasts if 8-way direction changes angle, and by how much.
# Allows for skipped inputs to be interpreted and hanled. 
# if 180 rotation occurs in a single frame, it will re-broadcast the previous movement.

func compare_angles(curr_angle, prev_angle):
	if prev_angle * curr_angle == 0: return 0 #nullify start/stop
	curr_rotation = (curr_angle - prev_angle + 12) % 8 -4
	if curr_rotation == -4: # checks for 180 rotation
		curr_rotation = prev_rotation
	return curr_rotation
	
func _on_inputs_changed(curr_left_angle, curr_right_angle, _timestamp):
	curr_left_rotation = compare_angles(curr_left_angle, prev_left_angle)
	curr_right_rotation = compare_angles(curr_right_angle, prev_right_angle)

	prev_left_angle = curr_left_angle
	prev_right_angle = curr_right_angle
	prev_left_rotation = curr_left_rotation
	prev_right_rotation = curr_right_rotation
	
	SignalBus.rotation_changed.emit(curr_left_rotation, curr_right_rotation, Time.get_ticks_msec())
