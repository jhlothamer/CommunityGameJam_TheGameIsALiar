extends Node

var allow_input : bool = true
var take_screen_shots : bool = false
var directory_name : String = ""
var file_counter : int = 0
export (int, 1, 100000) var file_counter_max : int = 1000
export (float, 0.0, 2.0) var resize_factor : float = 1.0
export var enabled : bool
var user_data_directory : Directory = Directory.new()

func _ready():
	user_data_directory.open("user://")


func _input(event):
	if !allow_input || !Input.is_action_just_pressed("screen_shot"):
		return
	allow_input = false
	$inputDebounceTimer.start()
	take_screen_shots = !take_screen_shots
	if take_screen_shots:
		directory_name = get_date_time_string()
		file_counter = 0
		user_data_directory.make_dir(directory_name)
		print("starting screenshots")
	else:
		print("stopping screenshots with " + String(file_counter) + " shots taken")

func _on_inputDebounceTimer_timeout():
	allow_input = true

func get_date_time_string():
	# year, month, day, weekday, dst (daylight savings time), hour, minute, second.
	var datetime = OS.get_datetime()
	return String(datetime["year"]) + i_to_padded(datetime["month"],2) + i_to_padded(datetime["day"],2) + "_" + i_to_padded(datetime["hour"],2) + i_to_padded(datetime["minute"],2) + i_to_padded(datetime["second"],2)

func i_to_padded(i : int, digits: int) -> String:
	return String(i).pad_zeros(digits)


func _process(delta):
	if !take_screen_shots || file_counter >= file_counter_max:
		return

	var image = get_viewport().get_texture().get_data()
	image.flip_y()
	if resize_factor != 1.0:
		var original_size = image.get_size()
		image.resize(original_size.x*resize_factor, original_size.y*resize_factor, Image.INTERPOLATE_BILINEAR)
	image.save_png("user://" + directory_name + "/" + i_to_padded(file_counter,4) + ".png")
	file_counter += 1
