extends Node2D

export var downward = false

func _ready():
	if downward:
		flip(true)

func flip(down = true):
	if down:
		rotation_degrees = 180.0
	else:
		rotation_degrees = 0.0
		
func set_fake_collision():
	$fatalFallArea.collision_layer = 2
	$fatalFallArea.collision_mask = 2