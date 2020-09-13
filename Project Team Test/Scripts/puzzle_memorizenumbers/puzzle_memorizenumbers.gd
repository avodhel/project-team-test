extends Node2D

signal puzzle_finished(event)

onready var memorize_numbers = $memorizenumbers 
onready var circles_and_numbers = $memorizenumbers/circlesandnumbers
onready var question1 = $question1_colorsnumber
onready var question2 = $question2_numberscolor

var circle_and_number_datas = []

func _ready():
	#fill circle and number datas array from circle and number nodes
	for can in circles_and_numbers.get_children():
		circle_and_number_datas.append(can)
	_puzzle_creater()

func _puzzle_creater() -> void:
	memorize_numbers.visible = true
	yield(get_tree().create_timer(1), "timeout")
	_question_selector()

#select randomly between questions
func _question_selector() -> void:
	memorize_numbers.visible = false
	randomize()
	var possibility = rand_range(0, 100)
	if possibility <= 33:
		question1.connect("result", self, "puzzle_checker")
		question1.visible = true
		question1.circle_and_number_datas = circle_and_number_datas
		question1.create_question()
	elif possibility > 33 && possibility <= 66:
		question2.connect("result", self, "puzzle_checker")
		question2.visible = true
		question2.circle_and_number_datas = circle_and_number_datas
		question2.create_question()
	else:
		print("question3 selected")

func puzzle_checker(result) -> void:
	print(result)
	emit_signal("puzzle_finished", "create_new_puzzle")
