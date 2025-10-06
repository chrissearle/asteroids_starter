extends Area2D

@export var max_frame_lifetime: = 240
@export var speed_max: = 210

var direction: = Vector2.ZERO
var frame_lifetime: = 0

func set_direction(radians: float) -> void:
	rotation = radians
	direction = Vector2.UP.rotated(rotation)

func _process(delta: float) -> void:
	frame_lifetime += 1

	if frame_lifetime > max_frame_lifetime:
		queue_free()

	position += direction * delta * speed_max

	# Make the bullet spin too
	rotation += 10 * delta
	rotation = fmod(rotation, TAU)
