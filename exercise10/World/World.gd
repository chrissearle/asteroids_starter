extends Node2D

@onready var screen_size: Vector2i = get_viewport().size

const asteroid = preload("res://Asteroid/Asteroid.tscn")

@onready var player: = $Player
@onready var bulletSound: = $BulletSoundPlayer
@onready var killSound: = $KillSoundPlayer
@onready var hitSound: = $HitSoundPlayer

func _ready() -> void:
	player.position = screen_size / 2
	
	var asteroid_instance: = asteroid.instantiate()
	
	add_child(asteroid_instance)
	asteroid_instance.position = screen_size / 4
	asteroid_instance.kill.connect(kill_player)

func bullet_fired() -> void:
	bulletSound.play()

func kill_player() -> void:
	killSound.play()
	player.queue_free()

func hit(area):
	pass
	
	# Play the hit sound
	
	# Remove the asteroid (the passed in area)
