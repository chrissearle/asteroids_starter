extends Node

var time_elapsed := 0.0

func reset() -> void:
	time_elapsed = 0.0

func minutes() -> float:
	return time_elapsed / 60

func seconds() -> float:
	return fmod(time_elapsed, 60)

func milliseconds() -> float:
	return fmod(time_elapsed, 1) * 100

func add(val: float) -> void:
	time_elapsed += val
