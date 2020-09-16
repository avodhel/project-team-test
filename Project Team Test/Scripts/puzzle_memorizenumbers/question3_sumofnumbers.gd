extends "res://Scripts/puzzle_memorizenumbers/question.gd"

onready var numbers = $numbers

var sum_of_numbers = 0

#prepare one real answer and two fake answers and fill container with them
func _prepare_answers() -> void:
	._prepare_answers() 
	container.clear()
	#find real answer
	for data in circle_and_number_datas:
		sum_of_numbers += data.number
	container.append(sum_of_numbers)
	#create two fake answers
	for fake_answer in 2:
		var rand_number = randi() % 3+1
		var possibility = rand_range(0, 100)
		if possibility < 50:
			fake_answer = sum_of_numbers + rand_number
		else:
			fake_answer = sum_of_numbers - rand_number
		if fake_answer > 0:
			container.append(fake_answer)
		else:
			container.append(0) 
	_prepare_numbers()

func _prepare_numbers() -> void:
	for number in numbers.get_children():
		number.prepare_number(_choose_rand_data_from_container(container))
		number.connect("clicked", self, "check_answer")

#check if clicked answer is correct or wrong
func check_answer(clicked_answer) -> void:
	if sum_of_numbers == clicked_answer:
		emit_signal("result", "correct")
	else:
		emit_signal("result", "wrong")
