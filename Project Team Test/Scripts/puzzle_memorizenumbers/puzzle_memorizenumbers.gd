extends Node2D

signal puzzle_started(describe)
signal puzzle_finished(event)

export (String) var describe_text

onready var memorize_numbers = $memorizenumbers 
onready var questions = $questions
onready var circles_and_numbers = $memorizenumbers/circlesandnumbers

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
	var ins_question = questions.get_child(randi() % questions.get_child_count())
	emit_signal("puzzle_started", ins_question.describe_text)
	ins_question.connect("result", self, "puzzle_checker")
	ins_question.visible = true
	ins_question.create_question(circle_and_number_datas)

func puzzle_checker(result) -> void:
	print(result)
	emit_signal("puzzle_finished", "create_new_puzzle")
