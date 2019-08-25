extends Control


func _ready():
	hide()

func _on_Continue_pressed():
	hide()
	get_tree().paused = false


func _on_restartBtn_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false


func _on_quitBtn_pressed():
	get_tree().quit()
