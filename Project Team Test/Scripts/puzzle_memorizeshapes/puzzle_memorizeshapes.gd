extends Node2D

signal puzzle_finished(event)

onready var memorizeshapes = $memorizeshapes
onready var shapes = $memorizeshapes/shapes
onready var question1 = $question1_whichshapewasnotthere

var shape_datas = []

func _ready():
	for shape in shapes.get_children():
		shape_datas.append(shape)
	#prepare question
	yield(get_tree().create_timer(5), "timeout")
	memorizeshapes.visible = false
	question1.visible = true
	question1.shape_datas = shape_datas
	question1.unused_shape_textures = memorizeshapes.texture_container
	question1.colors = memorizeshapes.colors
	question1.create_shapes()

func puzzle_checker(result) -> void:
	print(result)
	emit_signal("puzzle_finished", "create_new_puzzle")
