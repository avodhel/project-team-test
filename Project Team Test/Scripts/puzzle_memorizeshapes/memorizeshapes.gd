extends Node2D

export(Array,Texture) var shape_textures
export(Array,Color) var colors

onready var shapes = $shapes

var texture_container = []
var shape_texture_no
var choosen_shape
var color_container = []
var color_no
var choosen_color

func _on_memorizeshapes_visibility_changed():
	_prepare_data_containers()
	_prepare_shapes()

func _prepare_data_containers() -> void:
	#fill texture_container from shape_textures array to reuse later.
	texture_container.clear()
	for no in shape_textures.size():
		texture_container.append(shape_textures[no])
	#fill color_container from colors array to reuse later.
	color_container.clear()
	for no in colors.size():
		color_container.append(colors[no])

#prepare shapes according to random texture and color
func _prepare_shapes() -> void:
	randomize()
	for shape in shapes.get_children():
		shape.coll.disabled = true
		shape.prepare_shape(_select_shape_texture(), _select_shape_color())

func _select_shape_texture():
	shape_texture_no = randi() % texture_container.size()
	choosen_shape = texture_container[shape_texture_no]
	texture_container.erase(choosen_shape)
	return choosen_shape

func _select_shape_color():
	color_no = randi() % color_container.size()
	choosen_color = color_container[color_no]
	color_container.erase(choosen_color)
	return choosen_color
