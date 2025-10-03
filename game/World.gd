extends Node2D

var asteroids: Array[AsteroidResource] = [
	preload("res://Asteroid/large_asteroid_1.tres"),
	preload("res://Asteroid/large_asteroid_2.tres"),
	preload("res://Asteroid/large_asteroid_3.tres"),
	preload("res://Asteroid/large_asteroid_4.tres"),
	preload("res://Asteroid/large_asteroid_5.tres"),
	preload("res://Asteroid/large_asteroid_6.tres"),
	preload("res://Asteroid/large_asteroid_7.tres"),
	preload("res://Asteroid/large_asteroid_8.tres"),
	preload("res://Asteroid/large_asteroid_9.tres"),
	preload("res://Asteroid/large_asteroid_10.tres"),
	preload("res://Asteroid/small_asteroid_1.tres"),
	preload("res://Asteroid/small_asteroid_2.tres"),
	preload("res://Asteroid/small_asteroid_3.tres"),
	preload("res://Asteroid/small_asteroid_4.tres"),
	preload("res://Asteroid/small_asteroid_5.tres"),
	preload("res://Asteroid/small_asteroid_6.tres"),
	preload("res://Asteroid/small_asteroid_7.tres"),
	preload("res://Asteroid/small_asteroid_8.tres"),
	preload("res://Asteroid/small_asteroid_9.tres"),
	preload("res://Asteroid/small_asteroid_10.tres")
]

var asteroid_scene := preload("res://Asteroid/Asteroid.tscn")

@export var start_count := 7

@onready var screen_size: Vector2i = get_viewport().size

@onready var player := $Player
@onready var time_display := $TimeDisplay
@onready var restart_label := $RestartLabel
@onready var final_time_label := $FinalTime

var asteroid_count := 0
var break_count := 3

var alive := true

func _ready() -> void:
	restart_label.visible = false
	final_time_label.visible = false
	
	player.position = screen_size / 2

	for _i in range(start_count):
		build_asteroid(true)
	
	ScoreTime.reset()

func _process(delta: float) -> void:
	if (asteroid_count <= 0 or not alive):
		restart_label.visible = true
		final_time_label.visible = true
		final_time_label.text = "Time %02d:%02d:%02d" % [ScoreTime.minutes(), ScoreTime.seconds(), ScoreTime.milliseconds()]

		if Input.is_action_pressed("ui_accept"):
			get_tree().reload_current_scene()
	else:
		ScoreTime.add(delta)

func kill_player():
	AudioManager.play("res://Sounds/die.wav")
	player.queue_free()
	alive = false

func hit(area: Asteroid):
	var large = area.large
	var pos = area.global_position
	
	asteroid_count -= 1
	area.queue_free()

	if large:
		for _i in range(break_count):
			build_asteroid(false, pos)
	
	if asteroid_count <= 0:
		player.queue_free()

func build_asteroid(large: bool, fixed_position: Vector2 = Vector2.ZERO ) -> void:
	var asteroid_resource : AsteroidResource = asteroids.filter(func(res: AsteroidResource) -> bool: return res.large == large).pick_random()
	
	var asteroid_instance : Asteroid = asteroid_scene.instantiate()

	asteroid_count += 1
	
	add_child(asteroid_instance)
	
	asteroid_instance.init(asteroid_resource)

	var pos := fixed_position

	if pos == Vector2.ZERO:
		pos = Vector2(screen_size.x * randf(), screen_size.y * randf())
	
	asteroid_instance.global_position = pos
	asteroid_instance.kill.connect(kill_player)
