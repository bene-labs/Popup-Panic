extends BaseWindow

@export var min_taps := 1
@export var max_taps := 3
@export var spawn_area : Area2D
static var close_button = preload("res://nodes/close_button.tscn")

var total_taps := 1
var taps_left := 1
var prev_button = null

func _ready() -> void:
	super._ready()
	total_taps = randi_range(min_taps + max(0, int((difficulty - 5) / 2)), max_taps + int((difficulty - 1) / 2))
	taps_left = total_taps
	instruction_label.text = "Sponsored Content - press X %d more times to close" % taps_left
	spawn_button()


func _on_close_button_clicked():
	taps_left -= 1
	if taps_left <= 0:
		GameUI.score += 100 + 50 * total_taps
		queue_free()
		return
	instruction_label.text = "Sponsored Content - press X %d more times to close" % taps_left
	spawn_button()


func spawn_button():
	if prev_button != null:
		prev_button.queue_free()
	var col_shape = spawn_area.get_child(0)
	var centerpos = col_shape.global_position
	var size = col_shape.shape.extents
	var min = centerpos - size
	var max = centerpos + size
	var position_in_area : Vector2
	position_in_area.x = randf_range(min.x, max.x)
	position_in_area.y = randf_range(min.y, max.y)
	var new_button = close_button.instantiate()
	new_button.position = to_local(position_in_area)
	
	new_button.pressed.connect(_on_close_button_clicked)
	add_child(new_button)
	prev_button = new_button
