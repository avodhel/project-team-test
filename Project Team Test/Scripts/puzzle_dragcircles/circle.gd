extends Node2D

var drag_mouse = false

func _ready():
	pass # Replace with function body.

func _process(delta):
	if(drag_mouse):
		self.position = get_viewport().get_mouse_position()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton):
		if event.pressed:
			drag_mouse = true
		else:
			drag_mouse = false
