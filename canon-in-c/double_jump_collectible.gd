# Collectible.gd
extends Area2D

var ability = ""

func dete(body):
	print(body.name)
	if body.is_in_group("player"):
		body.unlock_ability(ability)
		queue_free()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
