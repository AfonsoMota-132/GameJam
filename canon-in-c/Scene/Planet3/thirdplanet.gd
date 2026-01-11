extends Node2D

@onready var spawnPoint := $SpawnPoint
@onready var doubleJump := $DoubleJump
@onready var gemPoint := $GemPoint
var PlayerScene := preload("res://Player/player.tscn")
var BorderScene := preload("res://extraScenes/Border.tscn")
var DoubleJump := preload("res://extraScenes/Collectable.tscn")
var Crystal := preload("res://extraScenes/Collectable.tscn")

func _on_collectable_collected(ability):
	if ability == "win":
		print("next stage yipieee")

func _ready():
	# Adding Player
	var player = PlayerScene.instantiate()
	player.global_position = spawnPoint.global_position
	player.can_double_jump = true
	player.can_dash = true
	add_child(player)
	# Adding Map Border and deathbox
	var border = BorderScene.instantiate()
	add_child(border)
	# Adding Crystal to end game
	var crystal = DoubleJump.instantiate()
	crystal.global_position = gemPoint.global_position
	crystal.ability = "win"
	crystal.image = "res://tiles/planet1/Gem.png"
	add_child(crystal)
	crystal.connect("collected", Callable(self, "_on_collectable_collected"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_dddelta: float) -> void:
	pass
