extends Control

signal NextLevel()

func _ready():
	SignalMgr.register_publisher(self, "NextLevel")
	$MarginContainer/playBtn.grab_focus()

func _on_playBtn_pressed():
	if $howToPlayPart1.is_done:
		#get_tree().change_scene("res://scenes/levels/testTileLevel1.tscn")
		emit_signal("NextLevel")
	else:
		$howToPlayPart1.next()
		if $howToPlayPart1.is_done:
			$MarginContainer/playBtn.text = "Play"


func _on_backBtn_pressed():
	get_tree().change_scene("res://scenes/title/title.tscn")

