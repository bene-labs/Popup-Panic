extends BaseWindow


func _on_close_button_pressed() -> void:
	GameUI.score += 100
	queue_free()
