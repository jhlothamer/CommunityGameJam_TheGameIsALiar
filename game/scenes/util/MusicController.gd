extends Control


# Load the music player node
onready var _player = $music_player

func _ready():
	play("res://assets/sounds/music/background.ogg")

# Calling this function will load the given track, and play it
func play(track_url : String):
	var track = load(track_url)
	_player.stream = track
	#_player.play()

# Calling this function will stop the music
func stop():
	_player.stop()