extends Area2D

@export var rotation_max: = 3
@export var max_speed: = 200

func _process(delta: float) -> void:
	var rotate_input = Input.get_axis("ui_left", "ui_right")
		
	rotation += rotation_max * rotate_input * delta

	rotation = fmod(rotation, TAU)

	var acceleration = Input.get_action_strength("ui_up")
	
	if acceleration > 0:
		# calculate the y component - remember that y increases as you move down
		
		# calculate the x component 
		
		# MOdify the player position
