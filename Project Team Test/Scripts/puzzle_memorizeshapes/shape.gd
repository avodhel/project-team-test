extends Node2D

signal result(event)

export(bool) var fake_shape
export (Texture) var shape_texture
export (Color) var shape_color

onready var sprite = $shape_area/Sprite
onready var coll = $shape_area/CollisionShape2D

func prepare_shape(_shape_texture, _color) -> void:
	shape_texture = _shape_texture
	shape_color = _color
	sprite.texture = shape_texture
	sprite.modulate = shape_color

func _on_shape_area_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		if fake_shape == true:
			emit_signal("result", "correct")
		else:
			emit_signal("result", "wrong")
