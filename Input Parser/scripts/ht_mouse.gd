
@icon("res://assets/computer-mouse-svgrepo-com.svg")
class_name HoldenTappsMouse
extends Node

@onready var reticle = %InputReticle
@onready var cursor = %Cursor
@onready var screen_size = get_viewport().size
@export var speed_scaler :float = 10.0
@export var rotation_scaler :float = PI / 8
@export var cursor_decay :float = 5 #Effective values: 1 to 20.
@export var reticle_decay :float = 20 #Effective values: 1 to 20.

var left_angle :int = 0
var right_angle :int = 0

func _ready():
	SignalBus.inputs_changed.connect(_on_inputs_changed)
	SignalBus.rotation_changed.connect(_on_rotation_changed)

func decay_function(curr_value: float, target_value: float, decay_ammount: float, delta_time):
	return target_value + (curr_value - target_value) * exp(-decay_ammount * delta_time)

func _on_visible_on_screen_notifier_2d_screen_exited():
	reticle.position.x = fposmod(reticle.position.x, screen_size.x)
	reticle.position.y = fposmod(reticle.position.y, screen_size.y)

func _on_inputs_changed(new_left_angle, new_right_angle, _timestamp):
	left_angle = new_left_angle
	right_angle = new_right_angle

func _on_rotation_changed(left_rotation, right_rotation, _timestamp):
	pass
	if left_angle and right_angle:
		reticle.position.x += ((left_rotation + right_rotation) * speed_scaler)
		reticle.position.y += ((left_rotation - right_rotation) * speed_scaler)
		reticle.rotation += (left_rotation + right_rotation) * rotation_scaler
	
func _process(delta):
	cursor.position.x = decay_function(cursor.position.x, reticle.position.x, cursor_decay, delta)
	cursor.position.y = decay_function(cursor.position.y, reticle.position.y, cursor_decay, delta)
	
	if not (left_angle or right_angle):
		reticle.position.x = decay_function(reticle.position.x, cursor.position.x, reticle_decay, delta)
		reticle.position.y = decay_function(reticle.position.y, cursor.position.y, reticle_decay, delta)
		pass
