extends Node2D

@onready var spawn_point := $SpawnPoint
var PlayerScene := preload("res://Player/player.tscn")
var DialogTutorial := preload("res://Dialog_tutorial.tscn")

func _ready():
	var player = PlayerScene.instantiate()
	player.global_position = spawn_point.global_position
	add_child(player)
	
	# Spawn the tutorial dialog (CanvasLayer handles camera-relative automatically)
	var tutorial_dialog = DialogTutorial.instantiate()
	add_child(tutorial_dialog)  # add to scene root (CanvasLayer stays on top)
	tutorial_dialog.get_node("Control/Label").text = "Welcome! Use arrows to move!"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
