extends Node2D

export (Array, Color) var colors

onready var circles_and_numbers = $circlesandnumbers

var choosen_color
var color_container = []
var color_no
var choosen_number
var number_container = []

func _ready():
	_prepare_data_containers()
	_prepare_circles_and_numbers()

func _prepare_data_containers() -> void:
	number_container.clear()
	for no in 10:
		number_container.append(no)
	#fill color_container from colors array to reuse later.
	color_container.clear()
	for no in colors.size():
		color_container.append(colors[no])

#prepare circles according to random number and color
func _prepare_circles_and_numbers() -> void:
	for can in circles_and_numbers.get_children():
		can.prepare_circle_and_number(_select_color(), _select_number())

func _select_number():
	randomize()
	choosen_number = number_container[randi() % number_container.size()]
	number_container.erase(choosen_number)
	return choosen_number

func _select_color():
	randomize()
	color_no = randi() % color_container.size()
	choosen_color = color_container[color_no]
	color_container.erase(choosen_color)
	return choosen_color
