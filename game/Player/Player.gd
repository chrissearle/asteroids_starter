extends Area2D

@export var rotation_max: = 3
@export var speed_max: = 200

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
			
		var direction = Vector2.ZERO.from_angle(rotation - (PI/2))
		position += direction.normalized() * speed_max * delta
	else:
		engineSound.stop()
		exhaust.emitting = false
	
	if Input.is_action_just_pressed("ui_select"):
		var bullet_instance = bullet.instantiate()
		bullet_instance.global_position = tip.global_position
		bullet_instance.set_direction(rotation)
		get_parent().add_child(bullet_instance)
		AudioManager.play("res://Sounds/shoot.wav")
		ScoreTime.add(5)
		bullet_instance.hit.connect(bullet_hit)

func bullet_hit(area: Asteroid) -> void:
	AudioManager.play("res://Sounds/boom.wav")
	get_parent().hit(area)
