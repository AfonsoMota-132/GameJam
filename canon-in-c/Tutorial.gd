extends Node2D

@onready var spawn_point := $SpawnPoint
var PlayerScene := preload("res://Player/player.tscn")

func _ready():
	var player = PlayerScene.instantiate()
	player.global_position = spawn_point.global_position
	add_child(player)
	
	# Spawn the tutorial dialog (CanvasLayer handles camera-relative automatically)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
