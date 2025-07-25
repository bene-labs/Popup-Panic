extends Button


func _on_pressed():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _ready():
	_on_window_resized()
	get_tree().root.size_changed.connect(_on_window_resized)
	
func _on_window_resized():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		hide()
	else:
		show()
