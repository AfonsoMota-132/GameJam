extends Node2D

@onready var nextScene = load("res://loading/loadingTutorial/loadingTutorial.tscn")

func _ready() -> void:
	# Show the dialogue
	DialogueManager.show_dialogue_balloon(
		load("res://Scene/History/History.dialogue")
	)
	# Connect the dialog_ended signal correctly
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _on_dialogue_ended(_resource):
	var scene_instance = nextScene.instantiate()
	var root = get_tree().get_root()
	var old_scene = get_tree().get_current_scene()
	root.call_deferred("add_child", scene_instance)
	get_tree().call_deferred("set_current_scene", scene_instance)
	if old_scene:
		old_scene.call_deferred("queue_free")
	# Dialogue is fully finished

func _on_dialogue_finished():
	print("Dialogue finished!")
	# Example: change scene
	# get_tree().change_scene_to_packed("res://Scene/NextScene.tscn")
