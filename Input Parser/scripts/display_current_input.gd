
extends PanelContainer

const ARROW_LOOKUP := ["⭘", "↑", "↗", "→", "↘", " ↓ ", "↙", "←", "↖"]
enum {LEFT_ARROW, LEFT_ANGLE, RIGHT_ANGLE, RIGHT_ARROW}

@onready var display_labels = $Divider.get_children()

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.inputs_changed.connect(_on_inputs_changed)


func _on_inputs_changed(left_angle, right_angle, _timestamp):
	
	display_labels[LEFT_ARROW].text = str(ARROW_LOOKUP[left_angle])
	display_labels[LEFT_ANGLE].text = str(left_angle)
	display_labels[RIGHT_ANGLE].text = str(right_angle)
	display_labels[RIGHT_ARROW].text = str(ARROW_LOOKUP[right_angle])
