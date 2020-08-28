extends Node2D

export (Array, Texture) var numbers

onready var sprite = $Sprite
onready var tween = $Sprite/Tween
onready var coll = $CollisionShape2D
onready var click_timer = $click_timer

var wait_time = 0.3

func _ready():
	click_timer.wait_time = wait_time

#choose 6 or 9 
func prepare_number(value) -> void:
	if value == 6:
		sprite.texture = numbers[0]
	else:
		sprite.texture = numbers[1]

func _on_6or9_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		tween.interpolate_property(self,"rotation_degrees",rotation_degrees, rotation_degrees + 180,wait_time,Tween.TRANS_LINEAR,Tween.EASE_IN)
		tween.start()
		coll.disabled = true
		click_timer.start()

func _on_click_timer_timeout():
	coll.disabled = false
