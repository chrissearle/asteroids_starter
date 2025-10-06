extends Area2D

var direction = Vector2.ZERO
var frame_lifetime: = 0

@export var max_frame_lifetime: = 240
@export var speed_max: = 210

signal hit

func set_direction(rads: float) -> void:
	rotation = rads
	direction = Vector2.UP.rotated(rotation)

func _process(delta: float) -> void:
	frame_lifetime += 1
	
	if frame_lifetime > max_frame_lifetime:
		queue_free()
	
	position += direction * delta * speed_max
	
	# Make the bullet spin too
	rotation += 10 * delta
	rotation = fmod(rotation, TAU)


func _on_area_entered(area: Area2D) -> void:
	if area is Asteroid:
		queue_free()
		hit.emit(area as Asteroid)
