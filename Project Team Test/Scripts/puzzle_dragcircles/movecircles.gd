extends Node2D

onready var circle1 = $Circle1/Body
onready var circle2 = $Circle2/Body

func _process(delta):
	if circle1.drag_mouse:
		circle2.position = (-circle1.position) + (get_viewport().size)
	if circle2.drag_mouse:
		circle1.position = (-circle2.position) + (get_viewport().size)
