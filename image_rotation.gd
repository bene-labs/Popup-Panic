extends TextureRect

@onready var change_timer = $ChangeTimer

@export var textures : Array[Texture2D]
@export var min_delay := 0.5
@export var max_delay := 7


func _ready():
	change_timer.start(randf_range(min_delay, max_delay))
	texture = textures.pick_random()


func _on_change_time_timeout():
	if textures.size() <= 1:
		return
	var prev_texture = texture
	while texture == prev_texture:
		texture = textures.pick_random()
	change_timer.start(randf_range(min_delay, max_delay))
