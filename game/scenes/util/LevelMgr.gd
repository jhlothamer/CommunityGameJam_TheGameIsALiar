extends Node

var current_level_index = -1

var levels = [
	"res://scenes/levels/level_1.tscn",
	"res://scenes/levels/level_4.tscn",
	"res://scenes/levels/level_3.tscn",
	"res://scenes/levels/level_5.tscn",
	"res://scenes/levels/level_6.tscn",
	"res://scenes/levels/level_7.tscn",
	"res://scenes/levels/level_2.tscn"
]

func _ready():
	SignalMgr.register_subscriber(self, "NextLevel", "on_NextLevel")
	SignalMgr.register_subscriber(self, "GotoLevel", "on_GotoLevel")

func on_NextLevel():
	current_level_index += 1
	if current_level_index >= levels.size():
		get_tree().change_scene("res://scenes/credits/credits.tscn")
		current_level_index = 1
	else:
		get_tree().change_scene(levels[current_level_index])

func on_GotoLevel(level):
	current_level_index = level - 1
	on_NextLevel()