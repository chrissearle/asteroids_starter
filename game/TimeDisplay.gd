extends Node2D

@onready var minutes_label: = $Minutes
@onready var seconds_label: = $Seconds
@onready var milliseconds_label: = $Milliseconds

func _process(_delta: float) -> void:
	minutes_label.text = "%02d" % [ScoreTime.minutes()]
	seconds_label.text = "%02d" % [ScoreTime.seconds()]
	milliseconds_label.text = "%02d" % [ScoreTime.milliseconds()]
