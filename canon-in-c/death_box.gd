# Collectible.gd
extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		body.died = true

func collect():
	queue_free()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
