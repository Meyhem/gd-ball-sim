extends Node2D

var right_mouse_held: bool = false

@export var attraction_strength: float = 1000.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	set_physics_process(true)
	var ball_scene = preload("res://scenes/ball.tscn")
	var screen_size = get_viewport().get_visible_rect().size
	for i in range(50):
		var ball = ball_scene.instantiate()
		ball.position = Vector2(randf() * screen_size.x - screen_size.x / 2, randf() * screen_size.y - screen_size.y / 2)
		ball.radius = randf() * 10 + 5
		ball.nudge()
		$Nucleus.add_child(ball)

func _physics_process(_delta: float) -> void:
	var balls = $Nucleus.get_children()
	if balls.size() < 2:
		return
	var centroid = Vector2.ZERO
	for ball in balls:
		centroid += ball.global_position
	centroid /= balls.size()
	for ball in balls:
		var direction = (centroid - ball.global_position).normalized()
		ball.apply_central_force(direction * attraction_strength)

