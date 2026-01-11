extends Node2D

@onready var spawnPoint := $SpawnPoint
@onready var doubleJump := $DoubleJump
@onready var gemPoint := $GemPoint
var PlayerScene := preload("res://Player/player.tscn")
var BorderScene := preload("res://extraScenes/Border.tscn")
var DoubleJump := preload("res://extraScenes/Collectable.tscn")
var Crystal := preload("res://extraScenes/Collectable.tscn")
var player = null
@onready var nextScene = load("res://Scene/Planet2/secondPlanet.tscn")

func _on_collectable_collected(ability):
	if ability != "win" or not player:
		return
	var scene_instance = nextScene.instantiate()
	var root = get_tree().get_root()
	var old_scene = get_tree().get_current_scene()
	root.call_deferred("add_child", scene_instance)
	get_tree().call_deferred("set_current_scene", scene_instance)
	if old_scene:
		old_scene.call_deferred("queue_free")


	# Move player to spawn point in the new scene
	var spawn_point = scene_instance.get_node("SpawnPoint")
	if spawn_point:
		player.global_position = spawn_point.global_position


func _ready():
	# Adding Player
	player = PlayerScene.instantiate()
	player.global_position = spawnPoint.global_position
	add_child(player)
	# Adding Map Border and deathbox
	var border = BorderScene.instantiate()
	add_child(border)
	# Adding Double Jump Collectable
	var double = DoubleJump.instantiate()
	double.global_position = doubleJump.global_position
	double.ability = "double_jump"
	double.image = "res://tiles/planet1/Boots.png"
	add_child(double)
	# Adding Crystal to end game
	var crystal = DoubleJump.instantiate()
	crystal.global_position = gemPoint.global_position
	crystal.ability = "win"
	crystal.image = "res://tiles/planet1/Gem.png"
	add_child(crystal)
	crystal.connect("collected", Callable(self, "_on_collectable_collected"))
	DialogueManager.show_dialogue_balloon( load("res://Scene/Planet1/Tutorial.dialogue"), "start")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
