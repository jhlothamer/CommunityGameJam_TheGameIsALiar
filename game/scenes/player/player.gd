extends KinematicBody2D

var reveal_ping_class = preload("res://scenes/revealPing/revealPing2.tscn")

var gravity_vector = Vector2(0, 900)
var floor_normal = Vector2.UP
var sloap_slide_stop = 25.0
var walk_speed = 300
var jump_speed = 450
#positive = right, negative = left
var face_direction : int = 1

export var max_wave_count : int = 6
export var sound_wave_generate_time : float = .12
export var sound_wave_width : float = 20.0
export var sound_wave_color : Color = Color("d28282")

export var disabled : bool
export var mute: bool

var linear_velocity = Vector2()

func _ready():
	if disabled:
		$stateMachine.disabled = true
		$Camera2D.current = false

func process_move_and_slide(delta):
	linear_velocity += delta * gravity_vector

	linear_velocity = move_and_slide(linear_velocity, floor_normal, sloap_slide_stop)

func process_horizontal_movement(delta):
	var target_speed = 0
	if Input.is_action_pressed("move_left"):
		target_speed -= 1
		face_direction = -1
	if Input.is_action_pressed("move_right"):
		target_speed += 1
		face_direction = 1
	target_speed *= walk_speed
	#linear_velocity.x = target_speed
	linear_velocity.x = lerp(linear_velocity.x, target_speed, .2)
	$Sprite.flip_h = face_direction < 0

func jump():
	linear_velocity.y -= jump_speed

func reveal_ping():
	var reveal_ping = reveal_ping_class.instance()
	reveal_ping.sound_wave_color = sound_wave_color
	reveal_ping.sound_wave_generate_time = sound_wave_generate_time
	reveal_ping.sound_wave_width = sound_wave_width
	reveal_ping.max_wave_count = max_wave_count
	reveal_ping.mute = mute
	get_parent().add_child(reveal_ping)
	reveal_ping.global_position = global_position

func play_anim(anim_name):
	if $AnimationPlayer.current_animation != anim_name:
		$AnimationPlayer.play(anim_name)


func start_alarm():
	$alarmBlinkTimer.start()
	$AlarmLbl.visible = true

func stop_alarm():
	$alarmBlinkTimer.stop()
	$AlarmLbl.visible = false


func _on_alarmBlinkTimer_timeout():
	$AlarmLbl.visible = !$AlarmLbl.visible
