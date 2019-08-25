extends Control


func _on_playBtn_pressed():
	get_tree().change_scene("res://scenes/levels/testLevel.tscn")


func _on_backBtn_pressed():
	get_tree().change_scene("res://scenes/title/title.tscn")

