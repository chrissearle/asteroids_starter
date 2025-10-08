extends Control

var game_scene := preload("res://World/World.tscn")

func _input(event: InputEvent) -> void:
	if event.is_action("start"):
		get_tree().change_scene_to_packed(game_scene)
