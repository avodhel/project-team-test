extends Node2D

signal player_failed

export(int) var health_counter = 12

onready var health_circles = $circles
onready var timer = $decrease_timer

func health_bar_changer(event, result) -> void:
	if result == "successful":
		_increase(3)
	elif result == "failed":
		_decrease(1)

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
		else:
			print("player failed")
			emit_signal("player_failed")

func _on_decrease_timer_timeout():
	_decrease(1)
