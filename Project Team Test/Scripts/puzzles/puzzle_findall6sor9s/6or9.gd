extends Node2D

signal checking_puzzle

export (int) var number
export (Array, Texture) var numbers

onready var sprite = $Sprite
onready var tween = $Tween
onready var coll = $CollisionShape2D
onready var click_timer = $click_timer

var wait_time = 0.3

func _ready():
	click_timer.wait_time = wait_time

#choose 6 or 9 
func prepare_number(value) -> void:
	number = value
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
		# change current number when clicked on it
		if number == 6:
			number = 9
		elif number == 9:
			number = 6

func _on_click_timer_timeout():
	coll.disabled = false

func _on_Tween_tween_completed(object, key):
	#emit signal to checking puzzle after every click and tween completed
	emit_signal("checking_puzzle")
