extends Area2D

export var downward = false

signal PlayerDied()

func _ready():
	SignalMgr.register_publisher(self, "PlayerDied")
	if downward:
		flip(true)

func flip(down = true):
	if down:
		rotation_degrees = 180.0
	else:
		rotation_degrees = 0.0
		
func set_fake_collision():
	$CollisionPolygon2D.disabled = true



func _on_spike_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("PlayerDied")
