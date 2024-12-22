extends Node

var dropped_input_timer = Time.get_ticks_msec()
var roll_duration = Time.get_ticks_msec()


# Called when the node enters the scene tree for the first time.
func _ready():
	prints ("Holden Tapp's Mouse Online", dropped_input_timer)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	# Case 0 (Null Input)
# 	If DroppedInputTimer Active
# 		Countdown DroppedInputTimer
# 		CurrInput = PrevInput
# 	Else
# 		Func ConvergePosition (Target.Position)
# 

# Case 1 (Single Input)
# 	If DroppedInputTimer Active
# 		Countdown DroppedInputTimer
# 		CurrInput = PrevInput
# 	Else
# 		Highlight JumpNode region
# 

# Case 2 (Second Input)
# 	If RollDuration < DoubleTapTimer
# 		If Double Down 
# 			Mouse Click On
# 		Else	
# 			If DoubleTapTimers Active
# 				Activate Tab
# 				Set TargetPosition from JumpNodeLookup Table
# 				Acceleration = MaxAcceleration
# 				Jolt = MaxJolt (Needed)
# 			Else
# 				Push Time to DoubleTapTimers
# 	Else
#	 	DroppedInputTimer = Reset to 0.25 sec
	dropped_input_timer = Time.get_ticks_msec()
#	
# 	Increase RollDuration
# 

# ## From All Cases
# ConvergePosition (Mouse.Position, Target.Position)
# 

# func converge_position (movable_position, target_position)
# 	If PrevInput = CurrInput
# 		Converge Jolt to MinJolt
# 		Converge Acceleration to MinAcceleration
# 	Else
# 		Calculate AngleDifferences
# 		Converge Jolt to MaxJolt
# 		Converge Acceleration to MaxAcceleration
# 	Converge Movable.Position to Target.Position
# 

# DroppedInputTimer Expired
# 	Mouse Click Off
# 	RollDuration = Reset to 0.0 sec
# 	Acceleration = Reset to .50 %
# 	Jolt = Reset to .50 %
# 

	pass
	
