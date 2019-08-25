extends Area2D

signal PlayerDied()

func _ready():
	SignalMgr.register_publisher(self, "PlayerDied")

func _on_fatalFallArea_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("PlayerDied")
