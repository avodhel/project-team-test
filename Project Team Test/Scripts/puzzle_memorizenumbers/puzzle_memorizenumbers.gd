extends Node2D

signal puzzle_started(describe)
signal puzzle_finished(event)

export (String) var describe_text

onready var memorize_numbers = $memorizenumbers 
onready var circles_and_numbers = $memorizenumbers/circlesandnumbers
onready var question1 = $question1_colorsnumber
onready var question2 = $question2_numberscolor
onready var question3 = $question3_sumofnumbers

var circle_and_number_datas = []

func _ready():
	#fill circle and number datas array from circle and number nodes
	for can in circles_and_numbers.get_children():
		circle_and_number_datas.append(can)
	_puzzle_creater()

func _puzzle_creater() -> void:
	emit_signal("puzzle_started", describe_text)
	memorize_numbers.visible = true
	yield(get_tree().create_timer(5), "timeout")
	_question_selector()

#select randomly between questions
func _question_selector() -> void:
	memorize_numbers.visible = false
	randomize()
	var possibility = rand_range(0, 100)
	if possibility <= 33:
		emit_signal("puzzle_started", question1.describe_text)
		question1.connect("result", self, "puzzle_checker")
		question1.visible = true
		question1.circle_and_number_datas = circle_and_number_datas
		question1.create_question()
	elif possibility > 33 && possibility <= 66:
		emit_signal("puzzle_started", question2.describe_text)
		question2.connect("result", self, "puzzle_checker")
		question2.visible = true
		question2.circle_and_number_datas = circle_and_number_datas
		question2.create_question()
	else:
		emit_signal("puzzle_started", question3.describe_text)
		question3.connect("result", self, "puzzle_checker")
		question3.visible = true
		question3.circle_and_number_datas = circle_and_number_datas
		question3.create_question()

func puzzle_checker(result) -> void:
	print(result)
	emit_signal("puzzle_finished", "create_new_puzzle")
