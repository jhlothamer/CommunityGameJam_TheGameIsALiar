extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var duration = 2.0
	var tween = $Tween
	tween.interpolate_property($Sprite, "scale", Vector2(1,1), Vector2(10,10), duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property($Sprite2, "scale", Vector2(1.5,1.5), Vector2(12.5,12.5), duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property($Sprite3, "scale", Vector2(2,2), Vector2(17,17), duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

	tween.interpolate_property($Light2D, "texture_scale", 1, 10, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property($Light2D2, "texture_scale", 1.5, 12.5, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property($Light2D3, "texture_scale", 2, 17, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()



func _on_Tween_tween_all_completed():
	queue_free()
