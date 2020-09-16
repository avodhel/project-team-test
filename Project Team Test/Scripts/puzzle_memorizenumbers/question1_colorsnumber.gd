extends "res://Scripts/puzzle_memorizenumbers/question.gd"

onready var question_circle_sprite = $question_circle/question_circle_sprite
onready var numbers = $numbers

var choosen_data

func _prepare_answers() -> void:
	._prepare_answers()
	choosen_data = circle_and_number_datas[randi() % circle_and_number_datas.size()]
	#assign color data to question circle
	question_circle_sprite.modulate = choosen_data.circle_color
	#fill number container from datas
	container.clear()
	for data in circle_and_number_datas:
		container.append(data.number)
	#assign numbers from datas
	for number in numbers.get_children():
		number.prepare_number(_choose_rand_data_from_container(container))
		number.connect("clicked", self, "check_answer")

#check if clicked number and color matched
func check_answer(clicked_answer) -> void:
	if choosen_data.number == clicked_answer:
		emit_signal("result", "correct")
	else:
		emit_signal("result", "wrong")
