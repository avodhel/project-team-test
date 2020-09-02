extends Node2D

export (PackedScene) var six_or_nine

onready var positions = $Positions

var less_number
var majority_number
var places = []

func _ready():
	places.clear()
	_puzzle_creater()

#create puzzle according to datas
func _puzzle_creater() -> void:
	less_number = _select_less_number()
	majority_number = _select_majority_number(less_number)
	var choosen_places = _get_choosen_places()
	#instance numbers
	for place in places:
		_instance_number(positions.get_child(place), majority_number)
	for choosen_place in choosen_places:
		_instance_number(positions.get_child(choosen_place), less_number)

#checking if the puzzle is finished
func puzzle_checker():
	var current_numbers = []
	for number in positions.get_child_count():
		current_numbers.append(positions.get_child(number).get_child(0).number)
	if current_numbers.has(less_number) == false:
		print("puzzle finished")

#which number gonna be less 6 or 9?
func _select_less_number():
	randomize()
	var possibility = rand_range(0, 100)
	if possibility <50:
		less_number = 6
	else:
		less_number = 9
	return less_number

#select majority number according to less number
func _select_majority_number(less_number):
	if less_number == 6:
		majority_number = 9
	else:
		majority_number = 6
	return majority_number

#selecting places for less number
func _get_choosen_places():
	#get available places for positions
	for place in positions.get_child_count():
		places.append(place)
	#choose three places from available places
	var choosen_places = []
	for counter in 3:
		var choosen_place = places[randi() % places.size()]
		places.erase(choosen_place)
		choosen_places.append(choosen_place)
	print(choosen_places)
	return choosen_places

#instance number according to value and set it to place
func _instance_number(place, value) -> void:
	var ins_six_or_nine = six_or_nine.instance()
	place.add_child(ins_six_or_nine)
	ins_six_or_nine.prepare_number(value)
	#signal connect to checking puzzle
	ins_six_or_nine.connect("checking_puzzle", self, "puzzle_checker");
