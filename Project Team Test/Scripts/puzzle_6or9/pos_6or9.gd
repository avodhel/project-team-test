extends Node2D

export (PackedScene) var six_or_nine

onready var pos = $Position2D

func _ready():
	var ins_six_or_nine = six_or_nine.instance()
	add_child(ins_six_or_nine)
	ins_six_or_nine.position = pos.position
