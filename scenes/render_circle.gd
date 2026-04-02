extends Node2D

@export var radius: float = 50.0


func _draw() -> void:
	draw_circle(Vector2.ZERO, radius, Color(0.5, 0.5, 0.5))
