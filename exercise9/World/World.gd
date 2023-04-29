extends Node2D

@onready var screen_size: Vector2i = get_viewport().size

const asteroid = preload("res://Asteroid/Asteroid.tscn")

@onready var player: = $Player
@onready var bulletSound: = $BulletSoundPlayer
@onready var killSound: = $KillSoundPlayer

func _ready() -> void:
	player.position = screen_size / 2
	
	var asteroid_instance: = asteroid.instantiate()
	
	add_child(asteroid_instance)
	asteroid_instance.position = screen_size / 4
	asteroid_instance.kill.connect(kill_player)

func bullet_fired() -> void:
	bulletSound.play()

func kill_player() -> void:
	pass
	
	# Play the kill sound
	
	# Remove the player (hint: queue_free)
