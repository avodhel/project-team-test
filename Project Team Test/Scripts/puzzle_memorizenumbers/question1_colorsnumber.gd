extends Node2D

signal result(event)

export (Array) var circle_and_number_datas

onready var question_circle_sprite = $question_circle/question_circle_sprite
onready var numbers = $numbers

var choosen_circle_and_number_data
var number_container = []

func create_question() -> void:
	#select random data from previous memorize numbers screen
	randomize()
	choosen_circle_and_number_data = circle_and_number_datas[randi() % circle_and_number_datas.size()]
	#assign color data to question circle
	question_circle_sprite.modulate = choosen_circle_and_number_data.circle_color
	#fill number container from datas
	number_container.clear()
	for data in circle_and_number_datas:
		number_container.append(data.number)
	#assign numbers from datas
	for number in numbers.get_children():
		number.prepare_number(_choose_number())
		number.connect("clicked", self, "check_number_and_color_match")

func _choose_number():
	var choosen_number = number_container[randi() % number_container.size()]
	number_container.erase(choosen_number)
	return choosen_number

#check if clicked number and color matched
func check_number_and_color_match(clicked_number) -> void:
	if clicked_number == choosen_circle_and_number_data.number:
		emit_signal("result", "correct")
	else:
		emit_signal("result", "wrong")
