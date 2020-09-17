extends Node2D

export (String) var describe_text
export (PackedScene) var shape
export (Array) var unused_shape_textures

onready var shape_positions = $shape_positions

var positions = []
var ins_shape
var rand_pos

func create_question(data_list, color_list) -> void:
	#positions to place shapes
	for pos in shape_positions.get_children():
		positions.append(pos)
	_prepare_answers(data_list, color_list)

#create answers according to previous shape datas
func _prepare_answers(shape_datas, colors) -> void:
	randomize()
	#create two shapes from shape datas
	for counter in 2:
		var data_no = randi() % shape_datas.size()
		var choosen_shape_data = shape_datas[data_no]
		shape_datas.remove(data_no) 
		_create_shape(choosen_shape_data.shape_texture, choosen_shape_data.shape_color)
	#create a fake shape (correct answer)
	var rand_unused_shape_texture = unused_shape_textures[randi() % unused_shape_textures.size()]
	var rand_color = colors[randi() % colors.size()]
	_create_shape(rand_unused_shape_texture, rand_color)
	ins_shape.fake_shape = true

#create shape with texture and color info
func _create_shape(texture, color) -> void:
	ins_shape = shape.instance()
	add_child(ins_shape)
	ins_shape.position = _select_position()
	ins_shape.prepare_shape(texture, color)
	#signal connect with parent to send puzzle result
	ins_shape.connect("result", self.get_parent().get_parent(), "puzzle_checker")

#select position for shapes
func _select_position():
	randomize()
	var rand_pos_no = randi() % positions.size()
	rand_pos = positions[rand_pos_no]
	positions.remove(rand_pos_no)
	return rand_pos.position
