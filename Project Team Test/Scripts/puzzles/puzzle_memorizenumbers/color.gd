extends Node2D

signal clicked(color)

export (int) var color

onready var color_sprite = $Area2D/circle_sprite

func prepare_color(_color) -> void:
	color = _color
	color_sprite.modulate = color

func _on_Area2D_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		emit_signal("clicked", color)
