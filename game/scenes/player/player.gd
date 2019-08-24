extends KinematicBody2D

var reveal_ping_class = preload("res://scenes/revealPing/revealPing.tscn")

var gravity_vector = Vector2(0, 900)
var floor_normal = Vector2.UP
var sloap_slide_stop = 25.0
var walk_speed = 500
var jump_speed = 500


var linear_velocity = Vector2()



func process_move_and_slide(delta):
	linear_velocity += delta * gravity_vector

	linear_velocity = move_and_slide(linear_velocity, floor_normal, sloap_slide_stop)

func process_horizontal_movement(delta):
	var target_speed = 0
	if Input.is_action_pressed("move_left"):
		target_speed -= 1
	if Input.is_action_pressed("move_right"):
		target_speed += 1
	target_speed *= walk_speed
	linear_velocity.x = target_speed

func jump():
	linear_velocity.y -= jump_speed

func reveal_ping():
	var reveal_ping = reveal_ping_class.instance()
	get_parent().add_child(reveal_ping)
	reveal_ping.global_position = global_position





