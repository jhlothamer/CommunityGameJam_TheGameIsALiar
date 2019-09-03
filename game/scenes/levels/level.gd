extends Node2D

export var skip_camera_setup : bool

signal MapBottomChange(bottom_y)

var map_depth

func _ready():
	SignalMgr.register_publisher(self, "MapBottomChange")
	if skip_camera_setup:
		return
	map_depth = $tileMapPrepper.get_level_bottom()
	var camera = $player/Camera2D
	camera.limit_bottom = map_depth
	$ParallaxBackground.scroll_limit_end.y = (camera.limit_bottom - 16.0) / camera.zoom.y
	call_deferred("report_map_depth")

func report_map_depth():
	emit_signal("MapBottomChange", map_depth)