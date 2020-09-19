extends "res://Scripts/puzzles/question.gd"

onready var numbers = $numbers

var sum_of_numbers = 0

#prepare one real answer and two fake answers and fill container with them
func _prepare_answers() -> void:
	._prepare_answers() 
	container.clear()
	_real_answer()
	_fake_answer(2)
	_prepare_numbers()

#find real answer
func _real_answer() -> void:
	for data in circle_and_number_datas:
		sum_of_numbers += data.number
	container.append(sum_of_numbers)

#create two fake answers
func _fake_answer(number_of_answer) -> void:
	for fake_answer in number_of_answer:
		var rand_number = randi() % 3+1
		var possibility = rand_range(0, 100)
		if possibility < 50:
			fake_answer = sum_of_numbers + rand_number
		else:
			fake_answer = sum_of_numbers - rand_number
		#prevent possibility of number below zero and duplication for answers.
		if fake_answer > 0:
			if container.has(fake_answer) == false:
				container.append(fake_answer)
			else:
				_fake_answer(1)
		else:
			container.append(0) 

func _prepare_numbers() -> void:
	for number in numbers.get_children():
		number.prepare_number(_choose_rand_data_from_container(container))
		number.connect("clicked", self, "check_answer")

#check if clicked answer is correct or wrong
func check_answer(clicked_answer) -> void:
	if sum_of_numbers == clicked_answer:
		emit_signal("result", "successful")
	else:
		emit_signal("result", "failed")
