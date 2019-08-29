extends Panel

var invisible_layer
var fake_layer

var is_done : bool = false

var invisible_tile_material = preload("res://assets/shaders/revealMaterial.tres")
var fake_tile_material = preload("res://assets/shaders/revealFakeMaterial.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	invisible_layer = $howToPlay1/invisible
	fake_layer = $howToPlay1/fake

	var duration = 4.0
	$Tween.interpolate_property(invisible_layer, "modulate", Color(1.0,1.0,1.0,1.0), Color(1.0,1.0,1.0,0.0), duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(fake_layer, "modulate", Color(1.0,1.0,1.0,0.0), Color(1.0,1.0,1.0,1.0), duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	$player.start_alarm()

func next():
	$Tween.stop_all()
	$instructions.text = "But fear not, noble bard, your courage you must pluck\r\nFor the Lyre of Truth will guide way\r\nWith every note that is struck"
	$pingTimer.start()
	$player.stop_alarm()
	invisible_layer.modulate= Color(1.0,1.0,1.0,1.0)
	fake_layer.modulate= Color(1.0,1.0,1.0,1.0)
	invisible_layer.material = invisible_tile_material
	fake_layer.material = fake_tile_material
	is_done = true


func _on_pingTimer_timeout():
	$player.reveal_ping()
