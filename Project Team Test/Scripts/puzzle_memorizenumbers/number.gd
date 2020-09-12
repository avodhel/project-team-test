extends Node2D

signal clicked(number)

export (int) var number

onready var number_label = $Area2D/number_label

func prepare_number(_no) -> void:
	number = _no
	number_label.text = number as String

func _on_Area2D_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		emit_signal("clicked", number)
