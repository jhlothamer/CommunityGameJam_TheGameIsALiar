extends Node

var current_state = null

func _ready():
	var host = get_parent()
	for child in get_children():
		child.init(self, host)
		if child.is_starting_state:
			current_state = child
	if current_state != null:
		current_state.enter()

func change_state(state_name):
	if current_state != null:
		current_state.exit()
	current_state = get_node(state_name)
	current_state.enter()

func _physics_process(delta):
	if current_state != null:
		current_state.update(delta)


