extends Area2D

@export var max_move: = 240
@export var speed_max: = 210

var direction: = Vector2.ZERO
var moved: = 0

signal hit

func set_direction(radians: float) -> void:
	rotation = radians
	direction = Vector2.UP.rotated(rotation)

func _process(delta: float) -> void:
	moved += 1

	if moved > max_move:
		queue_free()

	position += direction * delta * speed_max

	# Make the bullet spin too
	rotation += 10 * delta
	rotation = fmod(rotation, TAU)


func _on_area_entered(area: Area2D) -> void:
	pass
	
	# Emit the hit signal
