extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	var ball_scene = preload("res://scenes/ball.tscn")
	var screen_size = get_viewport().get_visible_rect().size
	for i in range(20):
		var ball = ball_scene.instantiate()
		ball.position = Vector2(randf() * screen_size.x - screen_size.x / 2, randf() * screen_size.y - screen_size.y / 2)
		ball.radius = randf() * 30 + 20
		ball.nudge()
		add_child(ball)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
