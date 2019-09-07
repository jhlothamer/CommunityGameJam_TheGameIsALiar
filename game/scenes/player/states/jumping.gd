extends "res://scenes/player/states/basePlayerStateNode.gd"

var jump_delta : float = 0.0
var leave_floor_time_allowance : float = 1.0


func enter():
	jump_delta = 0.0
	#jump starts an immediately - constant velocity up
	host.jump()
	host.play_anim("jump")
	$jumpTakeoffSound.play()

func update(delta):
	jump_delta += delta
	if host.is_on_floor() && jump_delta >= leave_floor_time_allowance:
		change_state("walking")
		return
	
	#as soon as the player stops pressing jump - start to fall
	#this give player control of how high to jump
	if !Input.is_action_pressed("jump"):
		host.linear_velocity.y = 0.0
	
	#if player let go of jump or gravity finally canceled out jump impulse, go to falling state
	if host.linear_velocity.y >= 0.0:
		change_state("falling")
		return
	
	host.process_horizontal_movement(delta)
	host.process_move_and_slide(delta)