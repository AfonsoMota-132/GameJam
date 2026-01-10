extends Control

@onready var label := $Label

func show_text(text: String):
	label.text = text
	show()

func hide_dialog():
	hide()
