extends Node2D

export(int) var health_counter = 12

onready var timer = $decrease_timer
onready var health_circles = $circles

func _increase(number):
	for counter in number:
		if health_counter < 12:
			health_circles.get_child(health_counter).health_state_checker("active")
			health_counter += 1

func _decrease(number):
	for counter in number:
		if health_counter > 0:
			health_counter -= 1
			health_circles.get_child(health_counter).health_state_checker("deactive")

func _on_increase_pressed():
	_increase(3)

func _on_descrease_pressed():
	_decrease(2)

func _on_decrease_timer_timeout():
	_decrease(1)
