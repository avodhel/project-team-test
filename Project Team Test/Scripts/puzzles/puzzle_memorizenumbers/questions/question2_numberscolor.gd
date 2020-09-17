extends "res://Scripts/puzzles/question.gd"

onready var question_number_label = $question_number/number_label
onready var colors = $colors

var choosen_data

func _prepare_answers() -> void:
	._prepare_answers()
	choosen_data = circle_and_number_datas[randi() % circle_and_number_datas.size()]
	#assign number data to question label
	question_number_label.text = choosen_data.number as String
	#fill color container from datas
	for data in circle_and_number_datas:
		container.append(data.circle_color)
	#assign colors from datas
	for color in colors.get_children():
		color.prepare_color(_choose_rand_data_from_container(container))
		color.connect("clicked", self, "check_answer")

func check_answer(clicked_answer) -> void:
	if choosen_data.circle_color == clicked_answer:
		emit_signal("result", "correct")
	else:
		emit_signal("result", "wrong")
