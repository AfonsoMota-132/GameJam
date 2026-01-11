extends Node2D

@onready var spawnPoint := $SpawnPoint
@onready var doubleJump := $DoubleJump
@onready var gemPoint := $GemPoint
var PlayerScene := preload("res://Player/player.tscn")
var BorderScene := preload("res://extraScenes/Border.tscn")
var DoubleJump := preload("res://extraScenes/Collectable.tscn")
var Crystal := preload("res://extraScenes/Collectable.tscn")
@onready var nextScene = preload("res://Scene/endScene/endScene.tscn")

func _on_collectable_collected(ability):
	if ability == "win":
		# Load next scene
		var scene_instance = nextScene.instantiate()
		# Free current scene and set new scene
		var old_scene = get_tree().get_current_scene()
		get_tree().set_current_scene(scene_instance)
		get_tree().get_root().add_child(scene_instance)
		if old_scene:
			old_scene.queue_free()
		

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
