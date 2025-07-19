extends ProgressBar

@export var deplete_speed := 5.0
@export var fill_speed := 1.5
@export var popup_holder : Node

func _process(delta: float) -> void:
	if popup_holder.get_child_count() == 0:
		self_modulate = Color.GREEN
		value -= deplete_speed * delta
	else:
		self_modulate = Color.RED
		value += fill_speed * popup_holder.get_child_count() * delta
		if value == 100:
			get_tree().change_scene_to_file("res://main_menu.tscn")
