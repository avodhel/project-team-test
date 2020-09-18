extends Node

signal puzzle_started(describe)
signal puzzle_finished(event, result)

export (String) var describe_text

func remove_puzzle(event, result) -> void:
	yield(get_tree().create_timer(0.5), "timeout")
	self.queue_free()
