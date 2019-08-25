extends Node2D

var sound_wave_class = preload("res://scenes/revealPing/soundWave.tscn")

var wave_count : int = 0
export var max_wave_count : int = 3
export var sound_wave_generate_time : float = 1.0
export var sound_wave_width : float = 20.0
export var sound_wave_color : Color = Color.yellow

# Called when the node enters the scene tree for the first time.
func _ready():
	create_sound_wave()
	$soundWaveGenerateTimer.start(sound_wave_generate_time)

func _on_Tween_tween_all_completed():
	queue_free()

func create_sound_wave():
	var sound_wave = sound_wave_class.instance()
	sound_wave.width = sound_wave_width
	sound_wave.color = sound_wave_color
	add_child(sound_wave)
	sound_wave.connect("SoundWaveComplete", self, "on_SoundWaveComplete")
	wave_count+=1

func on_SoundWaveComplete():
	if get_child_count() <= 1:
		queue_free()

func _on_soundWaveGenerateTimer_timeout():
	if wave_count >= max_wave_count:
		return
	create_sound_wave()