@icon("res://assets/keyboard-svgrepo-com.svg")
class_name HoldenTappsKeyboard

extends Node

enum Character_Layout {LAYOUT_LOWERCASE, LAYOUT_UPPERCASE, LAYOUT_NUMBERS, LAYOUT_SYMBOLS}
enum Handedness {HAND_LEFT_FIRST, HAND_RIGHT_FIRST}
enum D_Pad_Dirs {LURD_NEUTRAL, LURD_LEFT, LURD_UP, LURD_RIGHT, LURD_DOWN}
enum Face_Button_Dirs {WNES_NEUTRAL, WNES_WEST, WNES_NORTH, WNES_EAST, WNES_SOUTH}

const INPUT_LOOKUP_CHART = [
	[ # Lowercase Letters.
		[ # Left hand 1st.
			["⌂", "⋐", "⋒", "⋑", "⋓"],
			["⊏", "a", "q", "s", "z"],
			["⊓", "w", "e", "r", "d"],
			["⊐", "f", "t", "g", "b"],
			["⊔", "x", "c", "v", " "],
		],
		[ # Right hand 1st.
			["⌂", "⋐", "⋒", "⋑", "⋓"],
			["⊏", "h", "u", "l", "m"],
			["⊓", "y", "i", "p", ","],
			["⊐", "j", "o", "'", "."],
			["⊔", "n", "k", "?", " "],
		]
	],
	[ # Uppercase Letters.
		[ # Left hand 1st.
			["⌂", "⋐", "⋒", "⋑", "⋓"],
			["⊏", "A", "Q", "S", "Z"],
			["⊓", "W", "E", "R", "D"],
			["⊐", "F", "T", "G", "B"],
			["⊔", "x", "c", "V", " "],
		],
		[ # Right hand 1st.
			["⌂", "⋐", "⋒", "⋑", "⋓"],
			["⊏", "H", "U", "L", "M"],
			["⊓", "Y", "I", "P", ";"],
			["⊐", "J", "O", '"', ":"],
			["⊔", "N", "K", "↵", " "],
		]
	],
	[ # Numbers / Brackets / Cursor Control.   # TODO: Finish special keystroke lookup.
		[ # Left hand 1st.
			["⌂", "⋐", "⋒", "⋑", "⋓"],
			["⊏", "<", "1", ">", "z"],
			["⊓", "2", "3", "4", "d"],
			["⊐", "{", "5", "}", "b"],
			["⊔", "x", "c", "v", " "],
		],
		[ #RIght Hand 1st.
			["⌂", "⋐", "⋒", "⋑", "⋓"],
			["⊏", "[", "7", "(", "m"],
			["⊓", "6", "8", "0", ","],
			["⊐", "]", "9", ")", "."],
			["⊔", "n", "k", "↵", " "],
		]
	],
	[ # Symbols / Highlighting / Copy/Paste Shortcuts.   # TODO: Finish special keystroke lookup.
		[# Left hand 1st.
			["⌂", "⋐", "⋒", "⋑", "⋓"],
			["⊏", "A", "!", "S", "Z"],
			["⊓", "@", "#", "$", "D"],
			["⊐", "F", "%", "G", "B"],
			["⊔", "/", "|", "\\", " "],
		],
		[ # Right hand 1st.
			["⌂", "⋐", "⋒", "⋑", "⋓"],
			["⊏", "H", "&", "L", "M"],
			["⊓", "^", "*", ")", ";"],
			["⊐", "J", "(", '"', ":"],
			["⊔", "N", "K", "↵", " "],
		]
	],
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
