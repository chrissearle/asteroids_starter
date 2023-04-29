extends Area2D

@export var rotation_max: = 3
@export var speed_max: = 200

@onready var screen_size: Vector2i = get_viewport().size

@onready var tip: = $Tip
@onready var exhaust: = $Exhaust
@onready var engineSound: = $EngineSoundPlayer

const bullet: = preload("res://Bullet/Bullet.tscn")

func _process(delta: float) -> void:
	var rotate_input = Input.get_axis("ui_left", "ui_right")
	
	rotation += rotation_max * rotate_input * delta
	
	rotation = fmod(rotation, TAU)

	var acceleration = Input.get_action_strength("ui_up")
	
	if acceleration > 0:
		exhaust.emitting = true
		if engineSound.playing == false:
			engineSound.play()
		var y = -speed_max * cos(rotation)
		var x = speed_max * sin(rotation)
		
		position += Vector2(x, y) * delta
	else:
		engineSound.stop()
		exhaust.emitting = false
		
	screen_wrap()
	
	if Input.is_action_just_pressed("ui_select"):
		var bullet_instance = bullet.instantiate()
		bullet_instance.global_position = tip.global_position
		bullet_instance.set_direction(rotation)
		get_parent().add_child(bullet_instance)
		get_parent().bullet_fired()
		bullet_instance.hit.connect(bullet_hit)

func screen_wrap() -> void:
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)

func bullet_hit(area: Asteroid) -> void:
	get_parent().hit(area)
