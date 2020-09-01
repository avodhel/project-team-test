extends Node2D

export var speed = 100

onready var path_follow = $Path2D/PathFollow2D
onready var obstacle = $Path2D/PathFollow2D/Obstacle

var direction = 1 #left or right

func _process(delta):
	path_follow.offset += speed * direction * delta
	if direction > 0 and path_follow.unit_offset > 0.99: #if moving right
		direction = -1
	elif direction < 0 and path_follow.unit_offset < 0.01: #if moving left 
		direction = 1
