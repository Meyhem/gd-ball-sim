extends RigidBody2D

@export var radius: float = 50.0
@export var color: Color = Color.GRAY

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CollisionShape2D.shape.radius = radius
	$RenderCircle.radius = radius
	$RenderCircle.color = color


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func nudge() -> void:
	var force = Vector2(randf_range(-500, 500), randf_range(-500, 500))
	apply_central_impulse(force)
