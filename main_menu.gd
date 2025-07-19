extends Node2D

static var game = preload("res://game.tscn")

func _ready():
	if GameUI.score > 0:
		$ConfirmButton/Label.text = "Go again!"
		$Score.text = "Your score: %d" % GameUI.score
		$Score.show()
	if GameUI.high_score > 0:
		$Highscore.text = "Highscore: %d" % GameUI.score
		$Highscore.show()

func _on_confirm_button_pressed():
	get_tree().change_scene_to_packed(game)
