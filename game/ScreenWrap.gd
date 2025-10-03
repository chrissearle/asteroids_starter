extends Node2D

@onready var screen_size: Vector2i = get_viewport().size

@export var area: Area2D

func _process(_delta: float) -> void:
	screen_wrap()

func screen_wrap() -> void:
	area.position.x = wrapf(area.position.x, 0, screen_size.x)
	area.position.y = wrapf(area.position.y, 0, screen_size.y)
