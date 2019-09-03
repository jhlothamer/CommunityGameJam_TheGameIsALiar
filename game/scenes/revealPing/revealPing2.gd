extends Node2D

var sound_wave_class = preload("res://scenes/revealPing/soundWave2.tscn")

var wave_count : int = 0
export var max_wave_count : int = 3
export var sound_wave_generate_time : float = 1.0
export var sound_wave_width : float = 20.0
export var sound_wave_color : Color = Color.yellow
export var mute : bool
export var pitch_scale_start : float = .6
export var pitch_scale_increment : float = .2

var current_pitch_scale : float


export var radius : float = 20.0
export var number_of_segments : int = 35
export var width : float = 20.0
export var color : Color = Color.yellow
export var speed : float = 400.0
export var max_radius : float = 300.0
var current_radius : float = radius
var active : bool = true



signal RevealPingComplete()

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalMgr.register_publisher(self, "RevealPingComplete")
	current_pitch_scale = pitch_scale_start
	create_sound_wave()
	$soundWaveGenerateTimer.start(sound_wave_generate_time)

func create_sound_wave():
	var sound_wave = sound_wave_class.instance()
	sound_wave.width = sound_wave_width
	sound_wave.color = sound_wave_color
	sound_wave.mute = mute
#	sound_wave.pitch_scale = current_pitch_scale
#	current_pitch_scale += pitch_scale_increment
	add_child(sound_wave)
	sound_wave.connect("SoundWaveComplete", self, "on_SoundWaveComplete")
	wave_count+=1

func on_SoundWaveComplete():
	if get_child_count() <= 2:
		emit_signal("RevealPingComplete")
		call_deferred("queue_free")



func _on_soundWaveGenerateTimer_timeout():
	if wave_count >= max_wave_count:
		$soundWaveGenerateTimer.stop()
		emit_signal("RevealPingComplete")
		return
	create_sound_wave()