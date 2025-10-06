extends Node

var num_players := 2
const bus := "master"

var players: Array[AudioStreamPlayer] = []
var queue: Array[String] = []

var effects := {
	"shoot": preload("res://Sounds/shoot.wav"),
	"boom": preload("res://Sounds/boom.wav"),
	"die": preload("res://Sounds/die.wav"),
	"engine": preload("res://Sounds/engine.wav")
}

func _ready():
	for i in range(num_players):
		var p := AudioStreamPlayer.new()
		add_child(p)
		players.append(p)
		p.finished.connect(_on_stream_finished.bind(p))
		p.bus = bus

func _on_stream_finished(stream: AudioStreamPlayer):
	players.append(stream)

func play(sound_path: String):
	queue.append(sound_path)

func _process(_delta: float):
	if not queue.is_empty() and not players.is_empty():
		players[0].stream = effects[queue.pop_front()]
		players[0].play()
		players.pop_front()
