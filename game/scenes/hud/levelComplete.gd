extends Control

signal NextLevel()

func _ready():
	SignalMgr.register_publisher(self, "NextLevel")
	hide()

func _on_restartBtn_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false


func _on_quitBtn_pressed():
	get_tree().change_scene("res://scenes/title/title.tscn")
	get_tree().paused = false

func show():
	$VBoxContainer/HBoxContainer/continueBtn.grab_focus()
	.show()

func _on_continueBtn_pressed():
	emit_signal("NextLevel")
	get_tree().paused = false
