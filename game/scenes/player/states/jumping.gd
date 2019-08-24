extends "res://scenes/player/states/basePlayerStateNode.gd"

var jump_delta : float = 0.0
var leave_floor_time_allowance : float = .1

func enter():
	jump_delta = 0.0
	host.jump()

func update(delta):
	jump_delta += delta
	if host.is_on_floor() && jump_delta >= leave_floor_time_allowance:
		change_state("walking")
		return
	host.process_horizontal_movement(delta)
	host.process_move_and_slide(delta)