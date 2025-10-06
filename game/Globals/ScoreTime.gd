extends Node

var time_elapsed := 0.0

func reset() -> void:
	time_elapsed = 0.0

func minutes() -> int:
	return int(time_elapsed / 60)

func seconds() -> int:
	return int(fmod(time_elapsed, 60))

func milliseconds() -> int:
	return int(fmod(time_elapsed, 1) * 100)

func add(val: float) -> void:
	time_elapsed += val
