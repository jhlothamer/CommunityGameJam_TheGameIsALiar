extends Control

func _ready():
	hide()


func _on_restartBtn_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_quitBtn_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://scenes/title/title.tscn")

func show():
	$VBoxContainer/HBoxContainer/restartBtn.grab_focus()
	.show()