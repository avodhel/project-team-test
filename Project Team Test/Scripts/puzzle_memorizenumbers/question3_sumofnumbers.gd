extends Node2D

signal result(event)

export (Array) var circle_and_number_datas

onready var numbers = $numbers

var sum_of_numbers = 0
var answer_container = []

func create_question() -> void:
	_prepare_answers()
	for number in numbers.get_children():
		number.prepare_number(_choose_answer())
		number.connect("clicked", self, "check_answer")

#choose an answer from answer container
func _choose_answer():
	var choosen_answer = answer_container[randi() % answer_container.size()]
	answer_container.erase(choosen_answer)
	return choosen_answer

#prepare one real answer and two fake answers and fill answer container with them
func _prepare_answers() -> void: 
	answer_container.clear()
	#find real answer
	for data in circle_and_number_datas:
		sum_of_numbers += data.number
	answer_container.append(sum_of_numbers)
	#create two fake answers
	randomize()
	for fake_answer in 2:
		var rand_number = randi() % 3+1
		var possibility = rand_range(0, 100)
		if possibility < 50:
			fake_answer = sum_of_numbers + rand_number
		else:
			fake_answer = sum_of_numbers - rand_number
		if fake_answer > 0:
			answer_container.append(fake_answer)
		else:
			answer_container.append(0) 

#check if clicked answer is correct or wrong
func check_answer(clicked_answer) -> void:
	if sum_of_numbers == clicked_answer:
		emit_signal("result", "correct")
	else:
		emit_signal("result", "wrong")
