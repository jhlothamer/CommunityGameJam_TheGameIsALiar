extends "res://scenes/player/states/basePlayerStateNode.gd"

func enter():
	host.jump()

func update(delta):
	if host.is_on_floor():
		change_state("walking")
		return
	host.process_horizontal_movement(delta)
	host.process_move_and_slide(delta)