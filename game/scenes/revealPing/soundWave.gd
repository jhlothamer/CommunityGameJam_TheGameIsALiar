extends Node2D

export var radius : float = 20.0
export var number_of_segments : int = 35
export var width : float = 20.0
export var color : Color = Color.yellow
export var speed : float = 400.0
export var max_radius : float = 600.0
export var mute : bool
var current_radius : float = radius
var active : bool = true

export var random_pitch : bool
export var pitch_scale : float = 1.0

signal SoundWaveComplete()

func _ready():
	$Polygon2D.polygon = create_polygon_half()
	$Polygon2D2.polygon = create_polygon_half(-1)
	$Polygon2D.modulate = color
	$Polygon2D2.modulate = color
	if !mute:
		if random_pitch:
			randomize()
			$AudioStreamPlayer2D.pitch_scale = rand_range(.6, 1.6)
		else:
			$AudioStreamPlayer2D.pitch_scale = pitch_scale
		$AudioStreamPlayer2D.play()


func create_polygon_half(y_direction : int = 1):
	var polygon = PoolVector2Array()
	
	var v = Vector2(radius, 0.0)

	var rotate_multiplier : float = 1.0
	for i in range(2):
		for j in range(number_of_segments + 1):
			if j == 0:
				polygon.append(v)
			else:
				v = v.rotated(rotate_multiplier * PI / number_of_segments * y_direction)
				polygon.append(v)
		v = Vector2(v.x - width, v.y)
		rotate_multiplier = -1.0
	
	return polygon


func expand_polygon(polygon : PoolVector2Array, distance):
	for i in polygon.size():
		var v = polygon[i]
		var v2 = (v - Vector2.ZERO).normalized() * distance + v
		polygon.set(i, v2)
	return polygon

func _physics_process(delta):
	var distance = delta * speed
	current_radius += distance
	if current_radius > max_radius:
		emit_signal("SoundWaveComplete")
		queue_free()
		return
	$Polygon2D.polygon = expand_polygon($Polygon2D.polygon, distance)
	$Polygon2D2.polygon = expand_polygon($Polygon2D2.polygon, distance)
