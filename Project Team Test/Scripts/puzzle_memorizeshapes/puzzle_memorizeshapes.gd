extends Node2D

signal puzzle_started(describe)
signal puzzle_finished(event)

export (String) var describe_text

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
	emit_signal("puzzle_started", describe_text)
	memorizeshapes.visible = true
	yield(get_tree().create_timer(5), "timeout")
	_question_selector()

#select randomly between two questions
func _question_selector() -> void:
	memorizeshapes.visible = false
	randomize()
	var possibility = rand_range(0, 100)
	if possibility < 50:
		emit_signal("puzzle_started", question1.describe_text)
		question1.visible = true
		question1.shape_datas = shape_datas
		question1.unused_shape_textures = memorizeshapes.texture_container
		#we can directly assign colors because there's no erase option here
		question1.colors = memorizeshapes.colors
		question1.create_shapes()
	else:
		emit_signal("puzzle_started", question2.describe_text)
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
