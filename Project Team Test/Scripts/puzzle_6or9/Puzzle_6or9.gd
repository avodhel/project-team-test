extends Node2D

onready var numbers = $Numbers

func _ready():
	_puzzle_creater()

#create puzzle according to datas
func _puzzle_creater() -> void:
	var puzzle_type = _select_puzzle_type()
	var choosen_places = _get_choosen_places()
	var majority_number
	#select majority number according to puzzle type
	if puzzle_type == 6:
		majority_number = 9
	else:
		majority_number = 6
	#set numbers to places
	for place in numbers.get_child_count():
		for choosen_place in choosen_places:
			if place == choosen_place:
				#numbers.get_child(place).emit_signal("get_number", puzzle_type)
				pass
			else:
				#numbers.get_child(place).emit_signal("get_number", majority_number)
				pass

#which number gonna be less 6 or 9?
func _select_puzzle_type():
	var puzzle_type
	randomize()
	var possibility = rand_range(0, 100)
	if possibility <50:
		puzzle_type = 6
	else:
		puzzle_type = 9
	print(puzzle_type)
	return puzzle_type

#selecting places for less number
func _get_choosen_places():
	#get available places for numbers
	var places = []
	for place in numbers.get_child_count():
		places.append(place)
	#choose three places from available places
	var choosen_places = []
	for counter in 3:
		var choosen_place = places[randi() % places.size()]
		places.erase(choosen_place)
		choosen_places.append(choosen_place)
	print(choosen_places)
	return choosen_places

