extends "res://scenes/player/states/basePlayerStateNode.gd"

func enter():
	host.play_anim("fall")

func update(delta):
	if host.is_on_floor():
		$landingSound.play()
		change_state("walking")
		return
	host.process_horizontal_movement(delta)
	host.process_move_and_slide(delta)