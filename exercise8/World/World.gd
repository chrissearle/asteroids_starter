extends Node2D

@onready var screen_size: Vector2i = get_viewport().size

@onready var player: = $Player
@onready var bulletSound: = $BulletSoundPlayer

func _ready() -> void:
	player.position = screen_size / 2

func bullet_fired() -> void:
	# Play the bullet sound
	pass
