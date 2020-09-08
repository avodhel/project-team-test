extends Node2D

export(Array,Texture) var shape_textures

onready var shapes = $shapes

var texture_container = []
var shape_texture_no
var choosen_shape

func _ready():
	_puzzle_creater()

func _puzzle_creater() -> void:
	#fill texture_container from shape_textures to reuse.
	texture_container.clear()
	for no in shape_textures.size():
		texture_container.append(shape_textures[no])
	#select shapes randomly
	randomize()
	for shape in shapes.get_children():
		shape_texture_no = randi() % texture_container.size()
		choosen_shape = texture_container[shape_texture_no]
		texture_container.erase(choosen_shape)
		shape.prepare_shape(choosen_shape)
