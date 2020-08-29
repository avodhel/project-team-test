extends Node2D

export (Array, Color) var colors

onready var circle = $Circle/Sprite
onready var color_text = $ColorText

var color_texts = ["RED", "BLUE", "GREEN", "YELLOW"]
var color_no
var text_no

func _ready():
	_random_color_and_text()

func _random_color_and_text() -> void:
	randomize()
	#random circle color
	color_no = randi() % colors.size()
	circle.modulate = colors[color_no]
	#random text
	text_no = randi() % color_texts.size()
	color_text.text = color_texts[text_no]

#check if color and text matched
func _check_to_match():
	if color_no == text_no:
		return true
	else:
		return false

func _on_Circle_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		if _check_to_match() == true:
			print("successfull")
		else:
			print("failed")
