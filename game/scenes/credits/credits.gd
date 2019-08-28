extends Control

func _ready():
	$MarginContainer/backBtn.grab_focus()

func _on_backBtn_pressed():
	get_tree().change_scene("res://scenes/title/title.tscn")
