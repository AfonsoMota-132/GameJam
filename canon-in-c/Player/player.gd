extends CharacterBody2D

@export var speed := 160.0
@export var dash_speed := 240.0
@export var dash_time := 0.5
@export var death_time := 1.9
@export var jump_time := 0.5
@export var gravity := 700.0
@export var jump_velocity := -290.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var facing_dir := 1
var is_dashing := false
var dash_timer := 0.0
var double_jump := false
var can_double_jump := false
var can_dash := false
var died := false
var timer_death := 0.0
var	time_off_floor := 0.0

func get_ability(ability):
	if ability == "double_jump":
		can_double_jump = true
	elif ability == "dash":
		can_dash = true

func _physics_process(delta):
	if !died:
		if is_dashing:
			update_dash(delta)
		else:
			update_movement(delta)
		if is_on_floor() and double_jump:
			double_jump = false
		if is_on_floor():
			time_off_floor = 0.0
		else:
			time_off_floor += delta
	update_animation()
	if died:
		if timer_death == 0.0:
			timer_death = death_time
			velocity = Vector2(0.0, 0.0)
		else:
			timer_death -= delta
		if timer_death < 0.0:
			queue_free()
			get_tree().reload_current_scene()
			return ;
	move_and_slide()


func update_animation():
	if died:
		sprite.play("die")
	elif !is_on_floor() and time_off_floor >= 0.05:
		sprite.play("jump")
	elif is_dashing:
		sprite.play("dash")
	elif velocity.x != 0:
		sprite.play("walk")
	else:
		sprite.play("idle")
	if facing_dir > 0:
		sprite.flip_h = false
	elif facing_dir < 0:
		sprite.flip_h = true 

	move_and_slide()

func update_movement(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("Space") and !double_jump and !is_dashing:
		if is_on_floor()  or time_off_floor < 0.05:
			velocity.y = jump_velocity
		elif !is_on_floor() and can_double_jump:
			velocity.y = jump_velocity * 0.67
			double_jump = true


	var direction := Input.get_axis("Left", "Right")
	if direction != 0:
		facing_dir = sign(direction)

	if Input.is_action_just_pressed("Dash") and can_dash:
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

func _ready():
	return;
