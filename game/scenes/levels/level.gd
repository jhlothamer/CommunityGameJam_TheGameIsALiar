extends Node2D

func _ready():
	var map_depth = $tileMapPrepper.get_level_bottom()
	var camera = $player/Camera2D
	camera.limit_bottom = map_depth
	$ParallaxBackground.scroll_limit_end.y = map_depth / camera.zoom.y