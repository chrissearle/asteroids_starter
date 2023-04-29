extends Node2D

@onready var minutes_label: = $Minutes
@onready var seconds_label: = $Seconds
@onready var milliseconds_label: = $Milliseconds

func set_time(minutes, seconds, milliseconds):
	minutes_label.text = "%02d" % [minutes]
	seconds_label.text = "%02d" % [seconds]
	milliseconds_label.text = "%02d" % [milliseconds]
