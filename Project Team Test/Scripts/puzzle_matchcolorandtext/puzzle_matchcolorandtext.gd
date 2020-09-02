extends Node2D

export (PackedScene) var circle_and_text

onready var puzzle_timer = $puzzle_timer

var ins_circle_and_text

func _ready():
	_puzzle_creater()

func _puzzle_creater():
	puzzle_timer.start()
	ins_circle_and_text = circle_and_text.instance()
	add_child(ins_circle_and_text)
	#signal connect to stop puzzle
	ins_circle_and_text.connect("stop_puzzle", self, "stop_puzzle")

func _on_puzzle_timer_timeout():
	#remove current puzzle
	ins_circle_and_text.queue_free()
	#wait between two puzzles
	yield(get_tree().create_timer(0.2), "timeout")
	#create new puzzle
	_puzzle_creater()

#stop puzzle when clicked to circle
func stop_puzzle():
	ins_circle_and_text.queue_free()
	puzzle_timer.stop()
