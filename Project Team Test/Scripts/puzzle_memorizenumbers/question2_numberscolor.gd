extends Node2D

signal result(event)

export (String) var describe_text
export (Array) var circle_and_number_datas

onready var question_number_label = $question_number/number_label
onready var colors = $colors

var choosen_data
var color_container = []

func create_question() -> void:
	#select random data from previous memorize numbers screen
	randomize()
	choosen_data = circle_and_number_datas[randi() % circle_and_number_datas.size()]
	#assign number data to question label
	question_number_label.text = choosen_data.number as String
	#fill color container from datas
	for data in circle_and_number_datas:
		color_container.append(data.circle_color)
	#assign colors from datas
	for color in colors.get_children():
		color.prepare_color(_choose_color())
		color.connect("clicked", self, "check_color_and_number_match")

func _choose_color():
	var choosen_color = color_container[randi() % color_container.size()]
	color_container.erase(choosen_color)
	return choosen_color

func check_color_and_number_match(clicked_color) -> void:
	if clicked_color == choosen_data.circle_color:
		emit_signal("result", "correct")
	else:
		emit_signal("result", "wrong")
