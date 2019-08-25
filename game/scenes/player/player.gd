extends KinematicBody2D

var reveal_ping_class = preload("res://scenes/revealPing/revealPing.tscn")

var gravity_vector = Vector2(0, 900)
var floor_normal = Vector2.UP
var sloap_slide_stop = 25.0
var walk_speed = 300
var jump_speed = 450
#positive = right, negative = left
var face_direction : int = 1

var frames = {
	"idle": [0,1,2,3,4],
	"walking": [5,6,7,8],
	"jumping" : [9],
	"landing" : [10]
}

export var max_wave_count : int = 3
export var sound_wave_generate_time : float = 1.0
export var sound_wave_width : float = 20.0
export var sound_wave_color : Color = Color.yellow


var linear_velocity = Vector2()


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
	linear_velocity.x = target_speed
	$Sprite.flip_h = face_direction < 0

func jump():
	linear_velocity.y -= jump_speed

func reveal_ping():
	var reveal_ping = reveal_ping_class.instance()
	reveal_ping.sound_wave_color = sound_wave_color
	reveal_ping.sound_wave_generate_time = sound_wave_generate_time
	reveal_ping.sound_wave_width = sound_wave_width
	reveal_ping.max_wave_count = max_wave_count
	get_parent().add_child(reveal_ping)
	reveal_ping.global_position = global_position

func play_anim(anim_name):
	if $AnimationPlayer.current_animation != anim_name:
		$AnimationPlayer.play(anim_name)



