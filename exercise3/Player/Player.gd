extends Area2D

@export var rotation_max: = 3

func _process(delta: float) -> void:
	var rotate_input = Input.get_axis("ui_left", "ui_right")
	
	rotation += rotation_max * rotate_input * delta

	rotation = fmod(rotation, TAU)
