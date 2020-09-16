extends Node2D

signal puzzle_started(describe)
signal puzzle_finished(event)

export (String) var describe_text

onready var long_obstacle = $Long_Obstacle
onready var short_obstacle = $Short_Obstacle

var failed_control = false

func _ready():
	_puzzle_creater()

func _puzzle_creater() -> void:
	emit_signal("puzzle_started", describe_text)
	#signal connect for checking puzzle
	long_obstacle.connect("puzzle_checking", self, "puzzle_checker")
	short_obstacle.connect("puzzle_checking", self, "puzzle_checker")

func puzzle_checker(event) -> void:
	print(event)
	emit_signal("puzzle_finished", "create_new_puzzle")

func _on_point_area_body_entered(body):
	#when circle1 reachs to the success point
	if body.get_parent().name == "Circle1":
		puzzle_checker("successfull")
