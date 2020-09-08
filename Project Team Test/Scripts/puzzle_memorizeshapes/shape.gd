extends Node2D

onready var sprite = $Sprite

func prepare_shape(shape_texture) -> void:
	sprite.texture = shape_texture
	

