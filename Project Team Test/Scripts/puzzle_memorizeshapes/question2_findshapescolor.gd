extends Node2D

signal result(event)

export (Array) var shape_datas
export (Array) var colors

onready var sprite = $shape_sprite
onready var color_circles = $colorcircles

var choosen_shape_color

func create_question():
	_prepare_shape()
	_prepare_color_circles()

#preapare shape according to shape data
func _prepare_shape() -> void:
	randomize()
	var choosen_shape_data = shape_datas[randi() % shape_datas.size()]
	sprite.texture = choosen_shape_data.shape_texture
	choosen_shape_color = choosen_shape_data.shape_color

func _prepare_color_circles() -> void:
	randomize()
	for color_circle in color_circles.get_children():
		var choosen_color = colors[randi() % colors.size()]
		color_circle.prepare_color_circle(choosen_color)
		colors.erase(choosen_color)
		color_circle.connect("clicked", self, "check_color_match" )

#check if clicked color and shape's color matched
func check_color_match(color) -> void:
	if choosen_shape_color == color:
		emit_signal("result", "correct")
	else:
		emit_signal("result", "wrong")
