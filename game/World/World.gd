extends Node2D

var asteroids: Array[AsteroidResource] = [
	preload("res://Asteroid/Asteroids/large_asteroid_1.tres"),
	preload("res://Asteroid/Asteroids/large_asteroid_2.tres"),
	preload("res://Asteroid/Asteroids/large_asteroid_3.tres"),
	preload("res://Asteroid/Asteroids/large_asteroid_4.tres"),
	preload("res://Asteroid/Itera/large_asteroid_5.tres"),
	preload("res://Asteroid/Itera/large_asteroid_6.tres"),
	preload("res://Asteroid/Itera/large_asteroid_7.tres"),
	preload("res://Asteroid/Itera/large_asteroid_8.tres"),
	preload("res://Asteroid/Itera/large_asteroid_9.tres"),
	preload("res://Asteroid/Itera/large_asteroid_10.tres"),
	preload("res://Asteroid/Avatar/large_asteroid_avatar.tres"),
	preload("res://Asteroid/Asteroids/small_asteroid_1.tres"),
	preload("res://Asteroid/Asteroids/small_asteroid_2.tres"),
	preload("res://Asteroid/Asteroids/small_asteroid_3.tres"),
	preload("res://Asteroid/Asteroids/small_asteroid_4.tres"),
	preload("res://Asteroid/Itera/small_asteroid_5.tres"),
	preload("res://Asteroid/Itera/small_asteroid_6.tres"),
	preload("res://Asteroid/Itera/small_asteroid_7.tres"),
	preload("res://Asteroid/Itera/small_asteroid_8.tres"),
	preload("res://Asteroid/Itera/small_asteroid_9.tres"),
	preload("res://Asteroid/Itera/small_asteroid_10.tres"),
	preload("res://Asteroid/Avatar/small_asteroid_avatar.tres")
]

var include_itera := false
var include_avatar := true

func valid_path(path: String) -> bool:
	return path.contains("Asteroids") or (include_avatar and path.contains("Avatar")) or (include_itera and path.contains("Itera"))

var valid_asteroids := asteroids.filter(func(res: AsteroidResource) -> bool:	return valid_path(res.resource_path))

var large_asteroids := valid_asteroids.filter(func(res: AsteroidResource) -> bool: return res.large == true)
var small_asteroids := valid_asteroids.filter(func(res: AsteroidResource) -> bool: return res.large == false)

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
	randomize()

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

		if Input.is_action_just_pressed("start"):
			get_tree().reload_current_scene()
	else:
		ScoreTime.add(delta)

func kill_player():
	AudioManager.play("die")
	if is_instance_valid(player):
		player.queue_free()
	alive = false

func hit(area: Asteroid):
	var large = area.large
	var pos = area.global_position
	
	asteroid_count -= 1
	area.queue_free()

	if large:
		for _i in range(break_count):
			call_deferred("build_asteroid", false, pos)
	
	if asteroid_count <= 0 and is_instance_valid(player):
		player.queue_free()

func build_asteroid(large: bool, fixed_position: Vector2 = Vector2.ZERO) -> void:
	var asteroid_array := large_asteroids if large else small_asteroids

	var asteroid_resource: AsteroidResource = asteroid_array.pick_random()
	
	var asteroid_instance: Asteroid = asteroid_scene.instantiate()

	asteroid_count += 1
	
	add_child(asteroid_instance)
	
	asteroid_instance.init(asteroid_resource)

	var pos := fixed_position

	if pos == Vector2.ZERO:
		pos = Vector2(screen_size.x * randf(), screen_size.y * randf())
	
	asteroid_instance.global_position = pos
	asteroid_instance.kill.connect(kill_player)
