class_name BaseWindow
extends Node2D

static var popup_scenes : Array
@export var min_size = 0.3
@export var max_size = 1

@export var backgroud : Node2D
@export var add_textures : Array[Texture2D]
@export var add_image : TextureRect
@export var instruction_label : Label
var size := 1.0
var difficulty := 0.0

static func refresh_popup_scenes(difficulty):
	match popup_scenes.size():
		1:
			if difficulty >= 2:
				popup_scenes.push_back(load("res://nodes/random_close_popup.tscn"))
		2:
			if difficulty >= 3:
				popup_scenes.push_back(load("res://nodes/number_close_popup.tscn"))

static func spawn(difficulty, position):
	refresh_popup_scenes(difficulty)
	#var new_popup = load("res://nodes/random_close_popup.tscn").instantiate()
	var new_popup = popup_scenes.pick_random().instantiate()
	new_popup.difficulty = difficulty
	new_popup.size = randf_range(new_popup.min_size, new_popup.max_size)
	new_popup.backgroud.scale = Vector2(new_popup.size, new_popup.size)
	new_popup.global_position = position
	new_popup.add_image.texture = new_popup.add_textures.pick_random()
	return new_popup
	
