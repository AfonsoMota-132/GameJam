extends Node2D

@onready var spawnPoint := $SpawnPoint
@onready var dashPoint := $DashPoint
@onready var gemPoint := $GemPoint
var PlayerScene := preload("res://Player/player.tscn")
var BorderScene := preload("res://extraScenes/Border.tscn")
var Cloak := preload("res://extraScenes/Collectable.tscn")
var Crystal := preload("res://extraScenes/Collectable.tscn")
var player = null
@onready var nextScene = preload("res://loading/loadingLastStop/loadingLastStop.tscn")

func _dash_dialog(_ability):
	print("wtf")
	DialogueManager.show_dialogue_balloon( load("res://Scene/Planet1/Tutorial.dialogue"), "start")
	

func _on_collectable_collected(_ability):
	# Load next scene
	var scene_instance = nextScene.instantiate()
	# Free current scene and set new scene
	var old_scene = get_tree().get_current_scene()
	get_tree().set_current_scene(scene_instance)
	get_tree().get_root().add_child(scene_instance)
	if old_scene:
		old_scene.queue_free()

func _ready():
	var hasPlayer = find_child("Player", false, true)
	if !hasPlayer:
		player = PlayerScene.instantiate()
		player.global_position = spawnPoint.global_position
		player.can_double_jump = true
		call_deferred("add_child", player)
	# Adding Map Border and deathbox
	var border = BorderScene.instantiate()
	call_deferred("add_child", border)
	# Adding Double Jump Collectable
	var dash = Cloak.instantiate()
	dash.global_position = dashPoint.global_position
	dash.ability = "dash"
	dash.image = "res://tiles/planet2/Cloak.png"
	call_deferred("add_child", dash)
	# Adding Crystal to end game
	var crystal = Crystal.instantiate()
	crystal.global_position = gemPoint.global_position
	crystal.ability = "win"
	crystal.image = "res://tiles/planet1/Gem.png"
	call_deferred("add_child", crystal)
	dash.connect("collected", Callable(self, "_on_collectable_collected"))
	crystal.connect("collected", Callable(self, "_on_collectable_collected"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
