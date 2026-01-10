extends CharacterBody2D

@export var speed := 80.0
@export var dash_speed := 120.0
@export var dash_time := 0.5
@export var jump_time := 0.5
@export var gravity := 350.0
@export var jump_velocity := -85.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var facing_dir := 1
var is_dashing := false
var dash_timer := 0.0
var double_jump := false
var can_double_jump := false

func _on_Collectible_body_entered(body):
	print (body.name)
	match body.name:
		"DoubleJumpCollectible":
			print("collectable")
			can_double_jump = true
		#"DashCollectible":
		#	enable_dash()
	body.queue_free()

func _physics_process(delta):
	if is_dashing:
		update_dash(delta)
	else:
		update_movement(delta)
	if is_on_floor() and double_jump:
		double_jump = false
	update_animation()
	move_and_slide()

func update_animation():
	if !is_on_floor():
		sprite.play("jump")
	elif is_dashing:
		sprite.play("dash")
	elif velocity.x != 0:
		sprite.play("walk")
	else:
		sprite.play("idle")
	if facing_dir > 0:
		sprite.flip_h = false   # facing right
	elif facing_dir < 0:
		sprite.flip_h = true 

	move_and_slide()

func update_movement(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("Space") and !double_jump and !is_dashing:
		if !is_on_floor() and can_double_jump:
			velocity.y = jump_velocity
			double_jump = true
		elif is_on_floor():
			velocity.y = jump_velocity

	var direction := Input.get_axis("Left", "Right")
	if direction != 0:
		facing_dir = sign(direction)

	if Input.is_action_just_pressed("Dash"):
		start_dash()
		return

	velocity.x = direction * speed

func start_dash():
	is_dashing = true
	dash_timer = dash_time
	if !is_on_floor():
		dash_timer = dash_time / 4
	velocity.x = facing_dir * dash_speed
	velocity.y = 0

func update_dash(delta):
	dash_timer -= delta
	velocity.x = facing_dir * dash_speed

	if dash_timer <= 0:
		is_dashing = false
