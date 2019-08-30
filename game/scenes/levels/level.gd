extends Node2D

func _ready():
	var map_depth = $tileMapPrepper.get_level_bottom()
	var camera = $player/Camera2D
	camera.limit_bottom = map_depth
	$ParallaxBackground.scroll_limit_end.y = (camera.limit_bottom - 16.0) / camera.zoom.y