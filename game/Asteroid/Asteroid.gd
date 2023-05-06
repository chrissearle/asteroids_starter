class_name Asteroid

extends Area2D

@export var rotation_max: = 3.0
@export var speed_max: = 100

@export var large = true

var direction: = Vector2.ZERO
var rotation_speed: = 0

signal kill

func _ready() -> void:
	randomize()

	rotation = randf() * TAU
	
	direction = Vector2(build_random_direction(), build_random_direction())
	
	rotation_speed = (2 * rotation_max * randf()) - rotation_max

func _process(delta: float) -> void:
	position += direction * delta
	rotation += rotation_speed * delta

func build_random_direction() -> float:
	return (1.0 - randf() * 2) * speed_max * (1.0 + randf())

func _on_area_entered(area: Area2D) -> void:
	kill.emit()
