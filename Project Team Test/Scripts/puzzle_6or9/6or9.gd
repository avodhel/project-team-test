extends Node2D

export (Array, Texture) var numbers

onready var sprite = $Sprite
onready var tween = $Sprite/Tween
onready var coll = $CollisionShape2D
onready var click_timer = $click_timer

var wait_time = 0.3

# Called when the node enters the scene tree for the first time.
func _ready():
	click_timer.wait_time = wait_time
	_rand_number()

func _rand_number():
	randomize()
	sprite.texture = numbers[randi() % numbers.size()]

func _on_6or9_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		tween.interpolate_property(self,"rotation_degrees",rotation_degrees, rotation_degrees + 180,wait_time,Tween.TRANS_LINEAR,Tween.EASE_IN)
		tween.start()
		coll.disabled = true
		click_timer.start()

func _on_click_timer_timeout():
	coll.disabled = false
