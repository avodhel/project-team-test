extends Node2D

onready var coll = $Area2D/CollisionPolygon2D
onready var tween = $Tween
onready var click_timer = $click_timer

var wait_time = 0.3

func _ready():
	click_timer.wait_time = wait_time

func _on_Area2D_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		tween.interpolate_property(self,"rotation_degrees",rotation_degrees, rotation_degrees + 90,wait_time,Tween.TRANS_LINEAR,Tween.EASE_IN)
		tween.start()
		coll.disabled = true
		click_timer.start()

func _on_click_timer_timeout():
	coll.disabled = false
