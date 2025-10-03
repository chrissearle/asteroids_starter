extends Resource
class_name AsteroidResource

@export var pos := Vector2i(0, 0)
@export var region: bool
@export var large: bool
@export var tex : Texture2D = load("res://Assets/simpleSpace_tilesheet.png")
@export var scale := 1.0
@export var collision_shape: Shape2D
