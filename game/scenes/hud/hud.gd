extends CanvasLayer

var accept_keys : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalMgr.register_subscriber(self, "PlayerDied", "on_PlayerDied")
	SignalMgr.register_subscriber(self, "LevelComplete", "on_LevelComplete")


func on_PlayerDied():
	get_tree().paused = true
	$playerDied.show()

func on_LevelComplete():
	get_tree().paused = true
	$levelComplete.show()

func _physics_process(delta):
	if !accept_keys:
		return
	#if event.name == "ui_cancel" && event.pressed:
	if Input.is_action_just_pressed("ui_cancel") && !$playerDied.visible && !$levelComplete.visible:
		accept_keys = false
		$keyDebounceTimer.start()
		if $pause.visible:
			get_tree().paused = false
			$pause.hide()
		else:
			get_tree().paused = true
			$pause.show()

func _on_keyDebounceTimer_timeout():
	accept_keys = true
