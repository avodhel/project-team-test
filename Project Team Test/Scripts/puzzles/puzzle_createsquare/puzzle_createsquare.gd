extends "res://Scripts/puzzles/puzzle.gd"

onready var limit_timer = $limit_timer
onready var pieces = $square_pieces

var degrees = [0, 90, 180, 270]
var success_controls = []
var puzzle_completed_control = false

func _ready():
	_puzzle_creater()
	limit_timer.start()

func _puzzle_creater() -> void:
	emit_signal("puzzle_started", describe_text)
	for piece in pieces.get_children():
		#set random degree for every piece
		randomize()
		piece.rotation_degrees = degrees[randi() % degrees.size()]
		#signal connect to puzzle check after pieces rotated
		piece.connect("rotated", self, "puzzle_checker")

#check success control for every pieces
func puzzle_checker() -> void:
	success_controls.clear()
	for piece in pieces.get_children():
		success_controls.append(piece.success_control)
	if success_controls.has(false) == false:
		puzzle_completed_control = true
		emit_signal("puzzle_finished", "create_new_puzzle", "successful")

#when limit time to finish puzzle is over and puzzle isn't still completed
func _on_limit_timer_timeout():
	if puzzle_completed_control == false:
		emit_signal("puzzle_finished", "create_new_puzzle", "failed")
