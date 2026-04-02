extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	set_process_input(true)
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


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var click_pos_viewport = get_viewport().get_mouse_position()
		var camera = get_viewport().get_camera_2d()
		var click_pos_world = camera.get_viewport_transform().affine_inverse() * click_pos_viewport
		for child in get_children():
			if child is RigidBody2D:
				var direction = (click_pos_world - child.global_position).normalized()
				var impulse_strength = 1000.0
				var impulse = direction * impulse_strength
				child.apply_central_impulse(impulse)
