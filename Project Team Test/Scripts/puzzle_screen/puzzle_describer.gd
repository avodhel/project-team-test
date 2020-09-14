extends Node2D

export (String) var describer

onready var describer_label = $describer_label

func prepare_describer(text) -> void:
	describer = text
	describer_label.text = text

func clear_describer() -> void:
	describer_label.text = ""
