extends Node2D

signal rotated

export var success_control = false
export var success_degree = 0

onready var coll = $Area2D/CollisionPolygon2D
onready var tween = $Tween
onready var click_timer = $click_timer

var wait_time = 0.3

func _ready():
	click_timer.wait_time = wait_time
	#wait for success control a little bit to get corrent answer
	yield(get_tree().create_timer(0.1), "timeout")
	_success_controller()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		tween.interpolate_property(self,"rotation_degrees",rotation_degrees, rotation_degrees + 90,wait_time,Tween.TRANS_LINEAR,Tween.EASE_IN)
		tween.start()
		coll.disabled = true
		click_timer.start()

func _on_click_timer_timeout():
	coll.disabled = false

func _on_Tween_tween_all_completed():
	_success_controller()
	emit_signal("rotated")

#Is piece where it should be?
func _success_controller() -> void:
#	print(self.name , ":" , fmod(self.rotation_degrees, 360))
	if fmod(self.rotation_degrees, 360) == success_degree:
		success_control = true
	else:
		success_control = false

