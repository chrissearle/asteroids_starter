extends Area2D

@export var rotation_max: = 3

func _process(delta: float) -> void:
	var rotate_input = Input.get_axis("ui_left", "ui_right")
	
	# Exercise
	
	# Make the player rotate in response to the player input
	
	# Hint 1 - use this to set the player rotation
	
	# Hint 2 - Try not to let the rotation value get too large
