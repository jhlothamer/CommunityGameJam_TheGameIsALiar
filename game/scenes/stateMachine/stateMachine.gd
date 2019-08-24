extends Node

var current_state = null

export var debug : bool

func _ready():
	var host = get_parent()
	for child in get_children():
		child.init(self, host)
		if child.is_starting_state:
			current_state = child
	if current_state != null:
		print_debug("starting state is " + current_state.name)
		current_state.enter()
	else:
		print_debug("no starting state")


func change_state(state_name):
	if current_state != null:
		print_debug("exiting state " + current_state.name)
		current_state.exit()
	current_state = get_node(state_name)
	print_debug("entering state " + current_state.name)
	current_state.enter()

func _physics_process(delta):
	if current_state != null:
		current_state.update(delta)

func print_debug(msg):
	if !debug:
		return
	print(msg)