extends "res://scenes/player/states/basePlayerStateNode.gd"


func update(delta):
	if host.is_on_floor() && Input.is_action_just_pressed("jump"):
		change_state("jumping")
		return
	host.process_horizontal_movement(delta)
	host.process_move_and_slide(delta)