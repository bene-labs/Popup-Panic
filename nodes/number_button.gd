extends TextureButton

@export var click_sound := preload("res://sounds/button-click.mp3")


func _on_pressed():
	AudioPlayer.play(click_sound, randf_range(0.7, 1.2))


func show_number(nb):
	$Label.text = str(nb)
