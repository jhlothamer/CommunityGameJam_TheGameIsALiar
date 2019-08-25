extends Control


func _on_playBtn_pressed():
	get_tree().change_scene("res://scenes/howToPlay/howToPlay.tscn")


func _on_creditsBtn_pressed():
	get_tree().change_scene("res://scenes/credits/credits.tscn")


func _on_quitBtn_pressed():
	get_tree().quit()
