extends Button

var is_muted : bool
@export var mute_icon := preload("res://images/volume_off.png")
@export var sound_icon := preload("res://images/volume_up.png")
@onready var master_idx = AudioServer.get_bus_index("Master")

func _ready():
	is_muted = AudioServer.is_bus_mute(master_idx)
	icon = mute_icon if is_muted else sound_icon

func _on_pressed():
	is_muted = !is_muted
	AudioServer.set_bus_mute(master_idx, is_muted)
	icon = mute_icon if is_muted else sound_icon
