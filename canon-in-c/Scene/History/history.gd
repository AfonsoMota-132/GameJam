extends Node2D

signal dialog_ended

var dialogue_line: DialogueLine:
	set(next_line):
		dialogue_line = next_line
		if dialogue_line == null:
			emit_signal("dialog_ended")  # fires when dialogue ends

func _ready() -> void:
	# Show the dialogue
	var balloon = DialogueManager.show_dialogue_balloon(
		load("res://Scene/History/History.dialogue"),
        "start"
	)

	# Connect the dialog_ended signal correctly
	connect("dialog_ended", Callable(self, "_on_dialogue_finished"))

func _on_dialogue_finished():
	print("Dialogue finished!")
	# Example: change scene
	# get_tree().change_scene_to_packed("res://Scene/NextScene.tscn")
