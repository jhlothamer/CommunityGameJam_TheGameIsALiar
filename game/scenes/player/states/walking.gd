extends "res://scenes/player/states/basePlayerStateNode.gd"

var ping_allowed : bool = true

func update(delta):
	if host.is_on_floor() && Input.is_action_just_pressed("jump"):
		change_state("jumping")
		return
	elif !host.is_on_floor():
		change_state("falling")
		return
	if Input.is_action_just_pressed("reveal_ping") && ping_allowed:
		host.reveal_ping()
		ping_allowed = false
		$pingDebounceTimer.start()
	if host.linear_velocity.x == 0.0:
		host.play_anim("idle")
	else:
		host.play_anim("walk")
	host.process_horizontal_movement(delta)
	host.process_move_and_slide(delta)



func _on_pingDebounceTimer_timeout():
	ping_allowed = true
