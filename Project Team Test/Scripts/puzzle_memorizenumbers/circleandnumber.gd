extends Node2D

export (Color) var circle_color
export (int) var number

onready var circle_sprite = $circle_sprite
onready var number_label = $number_label

func prepare_circle_and_number(_color, _number) -> void:
	circle_color = _color
	number = _number
	circle_sprite.modulate = circle_color
	number_label.text = number as String
