extends Node2D

@onready var playButton: Button = $PlayButton
@onready var nextScene = preload("res://Scene/Planet1/tutorial.tscn")
func _ready():
	playButton.pressed.connect(_on_button_pressed)


func _on_button_pressed():
	get_tree().change_scene_to_packed(nextScene)
