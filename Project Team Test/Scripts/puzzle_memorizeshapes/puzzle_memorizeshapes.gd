extends Node2D

signal puzzle_finished(event)

onready var memorizeshapes = $memorizeshapes
onready var shapes = $memorizeshapes/shapes
onready var question1 = $question1_whichshapewasnotthere
onready var question2 = $question2_findshapescolor

var shape_datas = []

func _ready():
	#fill shape datas array from shape nodes
	for shape in shapes.get_children():
		shape_datas.append(shape)
	_puzzle_creater()

func _puzzle_creater() -> void:
	memorizeshapes.visible = true
	yield(get_tree().create_timer(1), "timeout")
	_question_selector()

#select randomly between two questions
func _question_selector() -> void:
	memorizeshapes.visible = false
	randomize()
	var possibility = rand_range(0, 100)
	if possibility < 50:
		question1.visible = true
		question1.shape_datas = shape_datas
		question1.unused_shape_textures = memorizeshapes.texture_container
		#we can directly assign colors because there's no erase option here
		question1.colors = memorizeshapes.colors
		question1.create_shapes()
	else:
		question2.connect("result", self, "puzzle_checker")
		question2.visible = true
		question2.shape_datas = shape_datas
		#get all colors because we'll erase them
		for no in memorizeshapes.colors.size():
			question2.colors.append(memorizeshapes.colors[no])
		question2.create_question()

func puzzle_checker(result) -> void:
	print(result)
	emit_signal("puzzle_finished", "create_new_puzzle")
