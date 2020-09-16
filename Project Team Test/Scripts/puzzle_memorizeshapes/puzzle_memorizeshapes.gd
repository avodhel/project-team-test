extends Node2D

signal puzzle_started(describe)
signal puzzle_finished(event)

export (String) var describe_text

onready var memorize_shapes = $memorizeshapes
onready var shapes = $memorizeshapes/shapes
onready var questions = $questions

var shape_datas = []

func _ready():
	#fill shape datas array from shape nodes
	for shape in shapes.get_children():
		shape_datas.append(shape)
	_puzzle_creater()

func _puzzle_creater() -> void:
	emit_signal("puzzle_started", describe_text)
	memorize_shapes.visible = true
	yield(get_tree().create_timer(5), "timeout")
	_question_selector()

#select randomly between two questions
func _question_selector() -> void:
	memorize_shapes.visible = false
	randomize()
	var ins_question = questions.get_child(randi() % questions.get_child_count())
	emit_signal("puzzle_started", ins_question.describe_text)
	if ins_question.has_signal("result"):
		ins_question.connect("result", self, "puzzle_checker")
	if "unused_shape_textures" in ins_question:
		ins_question.unused_shape_textures = memorize_shapes.texture_container
	#get all color datas and fill container
	var color_container = []
	for no in memorize_shapes.colors.size():
		color_container.append(memorize_shapes.colors[no])
	ins_question.create_question(shape_datas, color_container)
	ins_question.visible = true

func puzzle_checker(result) -> void:
	print(result)
	emit_signal("puzzle_finished", "create_new_puzzle")
