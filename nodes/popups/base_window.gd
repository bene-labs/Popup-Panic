class_name BaseWindow
extends Node2D

static var popup_scenes = [preload("res://nodes/popups/close_popup.tscn")]
static var min_size = 0.3
static var max_size = 1

@export var backgroud : Node2D
@export var add_textures : Array[Texture2D]
@export var add_image : TextureRect
var size := 1.0

static func spawn(difficulty, position):
	var new_popup = popup_scenes.pick_random().instantiate()
	new_popup.size = randf_range(min_size, max_size)
	new_popup.backgroud.scale = Vector2(new_popup.size, new_popup.size)
	new_popup.global_position = position
	new_popup.add_image.texture = new_popup.add_textures.pick_random()
	return new_popup
	
