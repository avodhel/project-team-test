extends Node2D

signal result(event)

export (String) var describe_text
export (Array) var circle_and_number_datas

var container = []

func create_question(data_list) -> void:
	circle_and_number_datas = data_list
	_prepare_answers()

func _prepare_answers() -> void:
	randomize()

func _choose_rand_data_from_container(container):
	var choosen_data = container[randi() % container.size()]
	container.erase(choosen_data)
	return choosen_data
