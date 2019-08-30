extends Node

var current_level_index = -1

var levels = [
	"res://scenes/levels/level_1.tscn",
	"res://scenes/levels/level_2.tscn",
	"res://scenes/levels/level_3.tscn"
]

func _ready():
	SignalMgr.register_subscriber(self, "NextLevel", "on_NextLevel")

func on_NextLevel():
	current_level_index += 1
	if current_level_index >= levels.size():
		get_tree().change_scene("res://scenes/credits/credits.tscn")
	else:
		get_tree().change_scene(levels[current_level_index])
