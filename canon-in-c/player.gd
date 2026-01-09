extends AnimatedSprite2D

const GRAVITY = 980 # Adjust as needed, project default is often used
var velocity = Vector2.ZERO

func _physics_process(delta):
	# Apply gravity when not on the floor
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	# Handle movement (e.g., left/right) here...
	# velocity.x = ...

	move_and_slide() # Moves the player and handles collisions

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
