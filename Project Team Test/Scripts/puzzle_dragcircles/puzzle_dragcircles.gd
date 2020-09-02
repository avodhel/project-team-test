extends Node2D

onready var long_obstacle = $Long_Obstacle
onready var short_obstacle = $Short_Obstacle

func _ready():
	#signal connect for checking puzzle
	long_obstacle.connect("puzzle_checking", self, "puzzle_checker")
	short_obstacle.connect("puzzle_checking", self, "puzzle_checker")

func puzzle_checker(event) -> void:
	if event == "failed":
		get_tree().paused = true
	yield(get_tree().create_timer(0.6), "timeout")
	#remove all child nodes
	for child in get_children():
		child.queue_free()
	print(event)

func _on_point_area_body_entered(body):
	#when circle1 reachs to the success point
	if body.get_parent().name == "Circle1":
		puzzle_checker("successfull")
