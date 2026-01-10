extends Control

@onready var label := $Label
var text = "Ola"


func show_text(text: String):
	label.text = text
	show()

func hide_dialog():
	hide()
