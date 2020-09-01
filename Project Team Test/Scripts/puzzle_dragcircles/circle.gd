extends KinematicBody2D

var mouse_entered = false
var drag_mouse = false
var draggingDistance = Vector2(0, 0)
var dir = 0

func _on_Body_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed() && mouse_entered:
			draggingDistance = position.distance_to(get_viewport().get_mouse_position())
			dir = (get_viewport().get_mouse_position() - position).normalized()
			drag_mouse = true
		else:
			drag_mouse = false
	elif event is InputEventMouseMotion:
		if drag_mouse:
			var newPosition = get_viewport().get_mouse_position() - draggingDistance * dir
			move_and_collide(newPosition - position )

func _on_Body_mouse_entered():
	mouse_entered = true
