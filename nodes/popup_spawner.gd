class_name  PopupSpawner
extends Node2D

@export var spawn_timer : Timer
@export var difficulty_timer : Timer
@export var spawn_area : Area2D
@export var popup_holder : Node
@export var init_min_delay := 2.0
@export var init_max_delay := 8.0
@export var difficulty_step := 0.1

static var highest_z_index = 0

var min_delay : float
var max_delay : float

static var difficulty = 1.0

func _ready() -> void:
	_on_game_start()

func _on_game_start():
	difficulty = 1.0
	highest_z_index = 0
	min_delay = init_min_delay
	max_delay = init_max_delay
	difficulty_timer.start()
	spawn_timer.start(0.2)
 

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
	var new_popup = BaseWindow.spawn(difficulty, position_in_area)
	new_popup.z_index = highest_z_index
	popup_holder.add_child(new_popup)


func _on_difficulty_timer_timeout() -> void:
	print(difficulty)
	difficulty += difficulty_step
	min_delay = max(0.1, init_min_delay - difficulty / 20)
	max_delay = max(0.4, init_max_delay - difficulty / 20)


func _on_spawn_timer_timeout() -> void:
	spawn_popup()
	spawn_timer.start(randf_range(min_delay, max_delay))
