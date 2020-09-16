extends "res://Scripts/puzzles/puzzle.gd"

onready var questions = $questions

var data_container = []
var ins_question

func _puzzle_creater() -> void:
	emit_signal("puzzle_started", describe_text)
	yield(get_tree().create_timer(5), "timeout")
	_question_selector()

func _question_selector() -> void:
	randomize()
	ins_question = questions.get_child(randi() % questions.get_child_count())
	emit_signal("puzzle_started", ins_question.describe_text)

func puzzle_checker(result) -> void:
	print(result)
	emit_signal("puzzle_finished", "create_new_puzzle")
