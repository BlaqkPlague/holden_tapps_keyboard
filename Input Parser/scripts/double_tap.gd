
extends Node
## Detects a Double Tap and emits a signal.
##
## Detects a Double Tap and emits a signal. Output signal: 
## double_tap_detected(

const ARROW_LOOKUP := ["⭘", "↑", "↗", "→", "↘", "↓", "↙", "←", "↖"]
# Seconds until each 
@export var doubletap_threshold: float = 0.25
@export var singletap_threshold: float = 0.1
@export var press_threshold: float = 0.5
@export var hold_threshold: float = 1.0
var doubletap_time: float = 0.0
var doubletap_available: bool = false
var prev_buttons: Array[Vector2i] = [Vector2i.ZERO, Vector2i.ZERO, Vector2i.ZERO]
var input_string: String = ""
 
func _ready() -> void:
	SignalBus.inputs_changed.connect(_on_inputs_changed)
	prints(Time.get_ticks_msec(), "DoubleTap Online.")

func _process(delta):
	doubletap_time += delta
	if doubletap_time > doubletap_threshold:
		prev_buttons[0] = Vector2i.ZERO
		doubletap_available = false
	
func _on_inputs_changed(curr_left_input, curr_right_input, _timestamp):
	prev_buttons.pop_back()
	prev_buttons.push_front(Vector2i(curr_left_input, curr_right_input))
	
	input_string = ""
	for pair in prev_buttons:
		input_string += "%s%s  " % [pair.x, pair.y]
	prints(input_string)
	
	if  doubletap_time <= doubletap_threshold and prev_buttons[2] == prev_buttons[0] and prev_buttons[0]: 
		if prev_buttons[1].x == 0 or prev_buttons[1].y == 0:
#			TODO: Refactor signals into Vector2i's and include L/R 1st variable.
#			TODO: v v v THIS WILL BECOME A SIGNAL! v v v
			print("DOUBLETAP: %s%s  " % [prev_buttons[0].x, prev_buttons[0].y]) 
			prev_buttons[2] = Vector2i.ZERO
	doubletap_time = 0
	
	doubletap_available = true
