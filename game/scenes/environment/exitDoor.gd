extends Area2D

signal LevelComplete()

func _ready():
	SignalMgr.register_publisher(self, "LevelComplete")


func _on_exitDoor_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("LevelComplete")
