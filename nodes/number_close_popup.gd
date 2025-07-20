extends BaseWindow

@export var is_ascending := true
@export var min_taps := 2
@export var max_taps := 3
@export var spawn_area : Area2D
var tap_count := 0
var needed_num := 1
var buttons : Array

static var num_button := preload("res://nodes/number_button.tscn")


func _ready() -> void:
	tap_count = randi_range(min_taps, max_taps + int((difficulty - 2) / 2))
	spawn_buttons()
	needed_num = 1 if is_ascending else tap_count


func spawn_buttons():
	for i in tap_count: 
		var col_shape = spawn_area.get_child(0)
		var centerpos = col_shape.global_position
		var size = col_shape.shape.extents
		var min = centerpos - size
		var max = centerpos + size
		var position_in_area : Vector2
		var new_button = num_button.instantiate()
		add_child(new_button)
		var buttons_overlap = true
		while buttons_overlap:
			position_in_area.x = randf_range(min.x, max.x)
			position_in_area.y = randf_range(min.y, max.y)
			new_button.position = to_local(position_in_area)
			buttons_overlap = false
			for b in buttons:
				if new_button.get_rect().intersects(b.get_rect()):
					buttons_overlap = true
					break
		
		new_button.show_number(i + 1)
		
		new_button.pressed.connect(_on_num_button_clicked.bind(new_button, i + 1))
		
		buttons.push_back(new_button)


func _on_num_button_clicked(button, num):
	if num == needed_num:
		button.disabled = true
		button.modulate = Color.WEB_GREEN
		needed_num += 1 if is_ascending else -1
		if (is_ascending and needed_num > tap_count) or (not is_ascending and needed_num < 1):
			GameUI.score += 100 * tap_count
			queue_free()
	else:
		for b in buttons:
			b.disabled = false
			button.modulate = Color.WHITE
		needed_num = 1 if is_ascending else tap_count
