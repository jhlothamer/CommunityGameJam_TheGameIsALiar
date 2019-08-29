extends Panel

var invisible_layer
var fake_layer


var current_part : int = 1

var is_done : bool = false

var invisible_tile_material = preload("res://assets/shaders/revealMaterial.tres")
var fake_tile_material = preload("res://assets/shaders/revealFakeMaterial.tres")

var color_visible : Color = Color(1.0,1.0,1.0,1.0)
var color_invisible : Color = Color(1.0,1.0,1.0,0.0)

# Called when the node enters the scene tree for the first time.
func _ready():
	invisible_layer = $howToPlay1/invisible
	fake_layer = $howToPlay1/fake
	fake_layer.modulate = color_invisible


func next():
	match current_part:
		1:
			part1()
		2:
			part2()
		3:
			part3()
		4:
			part4()
			is_done = true

func _on_pingTimer_timeout():
	$player.reveal_ping()

func part1():
	current_part += 1
	var duration = 4.0
	$Tween.interpolate_property(invisible_layer, "modulate", Color(1.0,1.0,1.0,1.0), Color(1.0,1.0,1.0,0.0), duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(fake_layer, "modulate", Color(1.0,1.0,1.0,0.0), Color(1.0,1.0,1.0,1.0), duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	#$player.start_alarm()

func part2() :
	current_part += 1
	$Tween.stop_all()
	$instructions.text = "But, noble bard, your courage you must pluck\r\nFor the Lyre of Truth will guide way\r\nWith every note that is struck"

func part3():
	current_part += 1
	$pingTimer.start()
	$player.stop_alarm()
	invisible_layer.modulate= Color(1.0,1.0,1.0,1.0)
	fake_layer.modulate= Color(1.0,1.0,1.0,1.0)
	invisible_layer.material = invisible_tile_material
	fake_layer.material = fake_tile_material
	$player.reveal_ping()

func part4():
	current_part += 1
	$pingTimer.stop()
	$instructions.text = "Good luck!"
	$instructions.align = Label.ALIGN_CENTER

