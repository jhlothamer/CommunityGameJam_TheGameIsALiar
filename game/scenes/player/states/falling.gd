extends "res://scenes/player/states/basePlayerStateNode.gd"

signal PlayerDied()
var fall_start_position
var max_fall_height = 2000

func _ready():
	SignalMgr.register_publisher(self, "PlayerDied")

func enter():
	host.play_anim("fall")
	fall_start_position = host.global_position

func update(delta):
	if host.is_on_floor():
		$landingSound.play()
		change_state("walking")
		return
	var fall_distance = host.global_position.y - fall_start_position.y
	if fall_distance >= max_fall_height:
		if !$fallingSound.playing:
			$fallingSound.play()
	
	host.process_horizontal_movement(delta)
	host.process_move_and_slide(delta)

func emit_player_died():
		emit_signal("PlayerDied")


func _on_fallingSound_finished():
		emit_signal("PlayerDied")

