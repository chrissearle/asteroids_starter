extends Area2D

@export var rotation_max: = 3
@export var speed_max: = 200

@onready var screen_size: Vector2i = get_viewport().size

func _process(delta: float) -> void:
	var rotate_input = Input.get_axis("ui_left", "ui_right")
		
	rotation += rotation_max * rotate_input * delta

	rotation = fmod(rotation, TAU)

	var acceleration = Input.get_action_strength("ui_up")
	
	if acceleration > 0:
		var y = -speed_max * cos(rotation)
		var x = speed_max * sin(rotation)

		position += Vector2(x, y) * delta
		
		screen_wrap()

func screen_wrap() -> void:
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)
