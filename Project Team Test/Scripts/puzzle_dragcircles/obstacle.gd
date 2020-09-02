extends Node2D

signal puzzle_checking(event)

export var speed = 100

onready var path_follow = $Path2D/PathFollow2D
onready var obstacle = $Path2D/PathFollow2D/Obstacle

var direction = 1 #left or right

#move obstacles
func _process(delta):
	path_follow.offset += speed * direction * delta
	if direction > 0 and path_follow.unit_offset > 0.99: #if moving right
		direction = -1
	elif direction < 0 and path_follow.unit_offset < 0.01: #if moving left 
		direction = 1

func _on_Obstacle_body_entered(body):
	if body.get_parent().name == "Circle1" || body.get_parent().name == "Circle2":
		emit_signal("puzzle_checking", "failed")
