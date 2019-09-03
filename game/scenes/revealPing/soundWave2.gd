extends Node2D

export var radius : float = 20.0
export var number_of_segments : int = 70
export var width : float = 20.0
export var color : Color = Color.yellow
export var speed : float = 400.0
export var max_radius : float = 300.0
export var mute : bool
var current_radius : float = radius
var active : bool = true

var circle_vectors

func _ready():
	circle_vectors = create_circle()

func create_circle():
	var polygon = PoolVector2Array()
	
	var v = Vector2(radius, 0.0)

	for i in range(number_of_segments + 1):
		if i == 0:
			polygon.append(v)
		else:
			v = v.rotated(2 * PI / number_of_segments)
			polygon.append(v)
	
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
	circle_vectors = expand_polygon(circle_vectors, distance)
	update()

func _draw():
	draw_polyline(circle_vectors, Color.gray.darkened(.5), 2.0, true)
