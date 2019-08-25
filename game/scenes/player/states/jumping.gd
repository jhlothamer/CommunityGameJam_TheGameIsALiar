extends "res://scenes/player/states/basePlayerStateNode.gd"

var jump_delta : float = 0.0
var leave_floor_time_allowance : float = .1

func enter():
	jump_delta = 0.0
	host.jump()
	host.play_anim("jump")

func update(delta):
	jump_delta += delta
	if host.is_on_floor() && jump_delta >= leave_floor_time_allowance:
		change_state("walking")
		return
	if host.linear_velocity.y >= 0.0:
		change_state("falling")
		return
	host.process_horizontal_movement(delta)
	host.process_move_and_slide(delta)