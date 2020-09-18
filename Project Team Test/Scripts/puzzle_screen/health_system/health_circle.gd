extends Node2D

export(String) var circle_state = "active"

onready var health_sprite = $fg_sprite

func health_state_checker(event) -> void:
	circle_state = event
	if "active" == circle_state:
		health_sprite.visible = true
	elif "deactive" == circle_state:
		health_sprite.visible = false
