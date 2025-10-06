extends Area2D

@export var max_frame_lifetime: = 240
@export var speed_max: = 210

var direction: = Vector2.ZERO
var frame_lifetime: = 0

func set_direction(radians: float) -> void:
	rotation = radians
	direction = Vector2.UP.rotated(rotation)

func _process(delta: float) -> void:
	# Count this frame

	# If lifetime exceeded - remove it (hint - queue_free)

	# Update the position
	
	# Make the bullet spin too
