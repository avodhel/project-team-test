extends Node2D

export (Array, PackedScene) var puzzles

onready var describer = $puzzle_describer

var ins_puzzle
var puzzle_no

func _ready():
	puzzle_selector("create_first_puzzle")

#select new puzzle after currrent puzzle finished
func puzzle_selector(event) -> void:
	describer.clear_describer()
	randomize()
	var rand_puzzle_no = randi() % puzzles.size()
	if event == "create_first_puzzle":
		_puzzle_creater(rand_puzzle_no)
	elif event == "create_new_puzzle":
		if rand_puzzle_no != puzzle_no:
			yield(get_tree().create_timer(0.3), "timeout")
			if ins_puzzle != null:
				ins_puzzle.queue_free()
			yield(get_tree().create_timer(1), "timeout")
			_puzzle_creater(rand_puzzle_no)
		else:
			puzzle_selector("create_new_puzzle")

#create new puzzle according to puzzle number
func _puzzle_creater(rand_puzzle_no) -> void:
		puzzle_no = rand_puzzle_no
		var puzzle = puzzles[rand_puzzle_no]
		ins_puzzle = puzzle.instance()
		ins_puzzle.connect("puzzle_started", describer, "prepare_describer")
		ins_puzzle.connect("puzzle_finished", self, "puzzle_selector")
		add_child(ins_puzzle)
