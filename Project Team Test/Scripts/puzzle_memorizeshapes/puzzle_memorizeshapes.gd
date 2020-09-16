extends "res://Scripts/puzzle_memorize.gd"

onready var memorize_shapes = $memorizeshapes
onready var shapes = $memorizeshapes/shapes

func _ready():
	#fill shape datas array from shape nodes
	for data in shapes.get_children():
		data_container.append(data)
	memorize_shapes.visible = true
	_puzzle_creater()

#select randomly between two questions
func _question_selector() -> void:
	memorize_shapes.visible = false
	._question_selector()
	if ins_question.has_signal("result"):
		ins_question.connect("result", self, "puzzle_checker")
	if "unused_shape_textures" in ins_question:
		ins_question.unused_shape_textures = memorize_shapes.texture_container
	#get all color datas and fill container
	var color_container = []
	for no in memorize_shapes.colors.size():
		color_container.append(memorize_shapes.colors[no])
	ins_question.create_question(data_container, color_container)
	ins_question.visible = true
