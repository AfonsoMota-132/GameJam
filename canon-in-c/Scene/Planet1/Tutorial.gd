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
	add_child(player)
	# Adding Map Border and deathbox
	var border = BorderScene.instantiate()
	add_child(border)
	# Adding Double Jump Collectable
	var double = DoubleJump.instantiate()
	double.global_position = doubleJump.global_position
	double.ability = "double_jump"
	double.image = "res://assets/Boots.png"
	add_child(double)
	# Adding Crystal to end game
	var crystal = DoubleJump.instantiate()
	crystal.global_position = gemPoint.global_position
	crystal.ability = "win"
	crystal.image = "res://assets/Gem.png"
	add_child(crystal)
	crystal.connect("collected", Callable(self, "_on_collectable_collected"))
	DialogueManager.show_dialogue_balloon( load("res://Scene/Planet1/Tutorial.dialogue"), "start")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
