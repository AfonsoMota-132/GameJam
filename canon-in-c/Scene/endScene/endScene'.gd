extends Node2D

@export var timer = 5.0

var time = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if has_node("TheEnd"):
		$TheEnd.visible = false
	if has_node("HeartEnd"):
		$HeartEnd.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if time < timer:
		time += delta
	
	if time > 2:
		if has_node("Planet"):
			$Planet.queue_free()
		if has_node("Boom"):
			$Boom.queue_free()
		if has_node("TheEnd"):
			$TheEnd.visible = true
		if has_node("HeartEnd"):
			$HeartEnd.visible = true
