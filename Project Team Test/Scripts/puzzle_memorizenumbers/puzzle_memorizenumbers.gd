extends "res://Scripts/puzzle_memorize.gd"

onready var memorize_numbers = $memorizenumbers 
onready var circles_and_numbers = $memorizenumbers/circlesandnumbers

func _ready():
	#fill circle and number datas array from circle and number nodes
	for data in circles_and_numbers.get_children():
		data_container.append(data)
	memorize_numbers.visible = true
	_puzzle_creater()

#select randomly between questions
func _question_selector() -> void:
	memorize_numbers.visible = false
	._question_selector()
	ins_question.connect("result", self, "puzzle_checker")
	ins_question.visible = true
	ins_question.create_question(data_container)
