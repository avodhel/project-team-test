extends Node2D

export (Array, PackedScene) var puzzles

onready var screen = $screen
onready var describer = $screen/puzzle_describer
onready var health_bar = $screen/health_bar
onready var status_label = $status_label

var ins_puzzle
var puzzle_no

func _ready():
	puzzle_selector("create_first_puzzle", null)
	health_bar.connect("player_failed", self, "stop_puzzle_screen")

#select new puzzle after currrent puzzle finished
func puzzle_selector(event, result) -> void:
	print(result)
	get_tree().paused = true
	describer.clear_describer()
	randomize()
	var rand_puzzle_no = randi() % puzzles.size()
	if event == "create_first_puzzle":
		_puzzle_creater(rand_puzzle_no)
	elif event == "create_new_puzzle":
		if rand_puzzle_no != puzzle_no:
			yield(get_tree().create_timer(1.5), "timeout")
			_puzzle_creater(rand_puzzle_no)
		else:
			puzzle_selector("create_new_puzzle", null)

#create new puzzle according to puzzle number
func _puzzle_creater(rand_puzzle_no) -> void:
	if ins_puzzle == null:
		puzzle_no = rand_puzzle_no
		var puzzle = puzzles[rand_puzzle_no]
		ins_puzzle = puzzle.instance()
		ins_puzzle.connect("puzzle_started", describer, "prepare_describer")
		ins_puzzle.connect("puzzle_finished", self, "puzzle_selector")
		ins_puzzle.connect("puzzle_finished", ins_puzzle, "remove_puzzle")
		ins_puzzle.connect("puzzle_finished", health_bar, "health_bar_changer")
		screen.add_child(ins_puzzle)
		get_tree().paused = false

func stop_puzzle_screen() -> void:
	screen.visible = false
	status_label.visible = true
	get_tree().paused = true
