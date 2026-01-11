extends Node2D

@export var timer := 5.0
@onready var title := $Title
@onready var background := $Background
@onready var planet1 : AnimatedSprite2D = $planet1
@onready var planet2 : AnimatedSprite2D = $planet2
@onready var planet3 : AnimatedSprite2D = $planet3
@onready var nextScene = load("res://Scene/Planet3/thirdplanet.tscn")
var time_passed := 0.0

func _ready() -> void:
	title.modulate = Color(0.0, 0.0, 0.0)

func _process(delta: float) -> void:
	time_passed += delta
	if time_passed < 2.5:
		var c: float = time_passed / 2.5
		title.modulate = Color(c, c, c)
	elif time_passed < 4:
		var t: float = (time_passed - 2.5) / (timer - 2.5)
		var c: float = lerp(1.0, 0.0, t)
		background.modulate = Color(c, c, c)
	elif time_passed < timer:
		var t: float = (time_passed - 4) / (timer - 4)
		var c: float = lerp(1.0, 0.0, t)
		title.modulate = Color(c, c, c)
		planet1.modulate = Color(c, c, c)
		planet2.modulate = Color(c, c, c)
		planet3.modulate = Color(c, c, c)
		background.modulate = Color(0.0, 0.0, 0.0)
	else:
		var scene_instance = nextScene.instantiate()
		var root = get_tree().get_root()
		var old_scene = get_tree().get_current_scene()
		root.call_deferred("add_child", scene_instance)
		get_tree().call_deferred("set_current_scene", scene_instance)
		if old_scene:
			old_scene.call_deferred("queue_free")
			set_process(false)
