extends Node2D

@export var radius: float = 50.0
@export var color: Color = Color(0.5, 0.5, 0.5)


func _draw() -> void:
	draw_circle(Vector2.ZERO, radius, color)
