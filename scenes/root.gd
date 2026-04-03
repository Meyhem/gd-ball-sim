extends Node2D

var right_mouse_held: bool = false

@export var attraction_strength: float = 1000.0
@export var launch_force: float = 5000.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	set_physics_process(true)
	var ball_scene = preload("res://scenes/ball.tscn")
	var screen_size = get_viewport().get_visible_rect().size
	for i in range(100):
		var ball = ball_scene.instantiate()
		ball.position = Vector2(randf() * screen_size.x - screen_size.x / 2, randf() * screen_size.y - screen_size.y / 2)
		ball.radius = randf() * 10 + 5
		ball.nudge()
		$Nucleus.add_child(ball)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		spawn_ball()

func spawn_ball() -> void:
	var ball_scene = preload("res://scenes/ball.tscn")
	var ball = ball_scene.instantiate()
	ball.mass = 50
	ball.radius = 20
	add_child(ball)

	# Set position to one of the corners
	var screen_size = get_viewport().get_visible_rect().size
	var corners = [
		Vector2(-screen_size.x / 2, -screen_size.y / 2),  # top-left
		Vector2(screen_size.x / 2, -screen_size.y / 2),   # top-right
		Vector2(-screen_size.x / 2, screen_size.y / 2),   # bottom-left
		Vector2(screen_size.x / 2, screen_size.y / 2)     # bottom-right
	]
	ball.position = corners[randi() % corners.size()]

	# Calculate centroid of Nucleus children
	var balls = $Nucleus.get_children()
	if balls.size() == 0:
		return
	var centroid = Vector2.ZERO
	for b in balls:
		centroid += b.global_position
	centroid /= balls.size()

	# Apply huge force towards centroid
	var direction = (centroid - ball.global_position).normalized()
	ball.apply_central_impulse(direction * launch_force)

	# Remove after 3 seconds
	await get_tree().create_timer(3.0).timeout
	ball.queue_free()

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
