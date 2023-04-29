extends Area2D

signal kill

func _on_area_entered(area: Area2D) -> void:
	emit_signal("kill")
