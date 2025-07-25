extends Node2D

static var game = preload("res://game.tscn")
@export var click_sound : AudioStream = preload("res://sounds/button-click.mp3")


func _ready():
	if FileAccess.file_exists("Highscore.sav"):
		var file = FileAccess.open("Highscore.sav", FileAccess.READ)
		GameUI.high_score = file.get_32()
		file.close()
	
	if GameUI.score > 0:
		$AudioStreamPlayer.stream = load("res://sounds/preview_4.mp3")
		$AudioStreamPlayer.play()
		$ConfirmButton/Label.text = "Go again!"
		$Score.text = "Your score: %d" % GameUI.score
		$Score.show()
	else:
		$AudioStreamPlayer.stream = load("res://sounds/windows-xp-startup.mp3")
		$AudioStreamPlayer.play()
	if GameUI.high_score > 0:
		$Highscore.text = "Highscore: %d" % GameUI.high_score
		$Highscore.show()


func _on_confirm_button_pressed():
	AudioPlayer.play(click_sound)
	get_tree().change_scene_to_packed(game)
