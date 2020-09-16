extends Node2D

signal result(event)

export (String) var describe_text

onready var sprite = $shape_sprite
onready var color_circles = $colorcircles

var choosen_shape_color

func create_question(data_list, color_list):
	_prepare_shape(data_list)
	_prepare_answers(color_list)

#preapare question's shape according to shape data
func _prepare_shape(shape_datas) -> void:
	randomize()
	var choosen_shape_data = shape_datas[randi() % shape_datas.size()]
	sprite.texture = choosen_shape_data.shape_texture
	choosen_shape_color = choosen_shape_data.shape_color

#prepare clickable color options
func _prepare_answers(colors) -> void:
	randomize()
	for color_circle in color_circles.get_children():
		var choosen_color = colors[randi() % colors.size()]
		color_circle.prepare_color_circle(choosen_color)
		colors.erase(choosen_color)
		color_circle.connect("clicked", self, "check_answer" )

#check if clicked color and shape's color matched
func check_answer(color) -> void:
	if choosen_shape_color == color:
		emit_signal("result", "correct")
	else:
		emit_signal("result", "wrong")
