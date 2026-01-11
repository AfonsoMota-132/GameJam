# Collectible.gd
extends Area2D

@onready var sprite := $Sprite
var ability = ""
var image: String = ""

signal collected(ability)

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	if image != "":
		sprite.texture = load(image)

func _on_body_entered(body):
	if body.name == "Player":
		if ability == "win":
			emit_signal("collected", ability)
		else:
			body.get_ability(ability)
		collect()

func collect():
	queue_free()
