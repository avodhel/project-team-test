extends Node2D

onready var sprite = $Sprite

func prepare_shape(shape_texture, color) -> void:
	sprite.texture = shape_texture
	sprite.modulate = color
	

