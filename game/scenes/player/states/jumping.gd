extends "res://scenes/player/states/basePlayerStateNode.gd"

var jump_delta : float = 0.0
var leave_floor_time_allowance : float = 1.0

var keep_accelerating: bool = false

func enter():
	jump_delta = 0.0
	keep_accelerating = true
	host.play_anim("jump")
	$jumpTakeoffSound.play()

func update(delta):
	jump_delta += delta
	if host.is_on_floor() && jump_delta >= leave_floor_time_allowance:
		change_state("walking")
		return
	
	if Input.is_action_pressed("jump") && keep_accelerating:
		keep_accelerating = host.jump(delta)
	else:
		keep_accelerating = false
	
	
	if host.linear_velocity.y >= 0.0:
		change_state("falling")
		return
	host.process_horizontal_movement(delta)
	host.process_move_and_slide(delta)