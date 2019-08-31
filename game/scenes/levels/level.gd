extends Node2D

export var skip_camera_setup : bool

func _ready():
	if skip_camera_setup:
		return
	var map_depth = $tileMapPrepper.get_level_bottom()
	var camera = $player/Camera2D
	camera.limit_bottom = map_depth
	$ParallaxBackground.scroll_limit_end.y = (camera.limit_bottom - 16.0) / camera.zoom.y