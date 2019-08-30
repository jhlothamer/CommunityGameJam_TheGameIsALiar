extends "res://scenes/player/states/basePlayerStateNode.gd"

var ping_complete : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalMgr.register_subscriber(self, "RevealPingComplete", "on_RevealPingComplete")



func on_RevealPingComplete():
	ping_complete = true
	
func enter():
	ping_complete = false
	host.play_anim("play")
	host.reveal_ping()

func update(delta):
	if Input.is_action_just_pressed("jump"):
		change_state("jumping")
		return
	if Input.is_action_just_pressed("move_left") || Input.is_action_just_pressed("move_right"):
		change_state("walking")
		return
	if ping_complete:
		change_state("walking")


