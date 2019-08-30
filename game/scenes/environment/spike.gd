extends Node2D

export var downward = false

func _ready():
	if downward:
		flip(true)

func flip(down = true):
	if down:
		$Sprite.flip_v = true
	else:
		$Sprite.flip_v = false