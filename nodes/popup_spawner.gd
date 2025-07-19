class_name  PopupSpawner
extends Node2D

@export var spawn_timer : Timer
@export var diffculty_timer : Timer
@export var spawn_area : Area2D
@export var popup_holder : Node
@export var init_min_delay := 1.0
@export var init_max_delay := 7.0
@export var difficulty_step := 0.1

static var highest_z_index = 0

var min_delay : float
var max_delay : float

var diffculty = 1.0

func _ready() -> void:
	_on_game_start()

func _on_game_start():
	highest_z_index = 0
	min_delay = init_min_delay
	max_delay = init_max_delay
	diffculty_timer.start()
	spawn_timer.start(randf_range(min_delay, max_delay))
 

func spawn_popup():
	var col_shape = spawn_area.get_child(0)
	var centerpos = col_shape.global_position
	var size = col_shape.shape.extents
	var min = centerpos - size
	var max = centerpos + size
	var position_in_area : Vector2
	position_in_area.x = randf_range(min.x, max.x)
	position_in_area.y = randf_range(min.y, max.y)
	await get_tree().process_frame
	var new_popup = BaseWindow.spawn(diffculty, position_in_area)
	new_popup.z_index = highest_z_index
	popup_holder.add_child(new_popup)


func _on_diffculty_timer_timeout() -> void:
	diffculty += difficulty_step
	min_delay = max(0.1, init_min_delay - diffculty / 5)
	max_delay = max(0.5, init_max_delay - diffculty / 5)


func _on_spawn_timer_timeout() -> void:
	spawn_popup()
	spawn_timer.start(randf_range(min_delay, max_delay))
