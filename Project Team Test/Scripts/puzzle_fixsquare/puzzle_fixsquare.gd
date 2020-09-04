extends Node2D

onready var pieces = $square_pieces

var degrees = [0, 90, 180, 270]
var success_controls = []

func _ready():
	_puzzle_creater()

func _puzzle_creater() -> void:
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
	print(success_controls)
	if success_controls.has(false) == false:
		print("puzzle finished")
