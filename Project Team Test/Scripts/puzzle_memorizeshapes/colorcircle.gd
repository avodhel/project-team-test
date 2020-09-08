extends Node2D

signal clicked(color)

onready var sprite =  $Area2D/Sprite

func prepare_color_circle(color) -> void:
	sprite.modulate = color

func _on_Area2D_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		emit_signal("clicked", sprite.modulate)
