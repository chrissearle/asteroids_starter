class_name Asteroid

extends Area2D

@export var rotation_max := 3.0
@export var speed_max := 100

@export var large := true

@onready var sprite := $Sprite2D
@onready var collision := $CollisionShape2D

const TILE := Vector2i(64, 64)

var direction := Vector2.ZERO
var rotation_speed := 0.0

signal kill

const defaultTexture := "res://Assets/simpleSpace_tilesheet.png"

func init(asteroid_resource: AsteroidResource) -> void:
	large = asteroid_resource.large

	sprite.texture = asteroid_resource.tex

	sprite.scale = Vector2(asteroid_resource.scale, asteroid_resource.scale)
	
	collision.shape = asteroid_resource.collision_shape

	if asteroid_resource.region:
		sprite.region_enabled = true
		
		var pixel_pos: Vector2i = asteroid_resource.pos * TILE
		
		sprite.region_rect = Rect2(pixel_pos, TILE)
	else:
		sprite.region_enabled = false

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

func _on_area_entered(_area: Area2D) -> void:
	kill.emit()
