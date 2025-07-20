class_name GameUI
extends Node2D

@export var score_label : Label
@export var high_score_label : Label
@export var base_points_per_seconds := 5.0
static var score := 0.0
static var high_score := 0


func _ready() -> void:
	score = 0.0
	high_score_label.text = "Highscore: %d" % int(high_score)


func _process(delta: float) -> void:
	score += base_points_per_seconds * delta * PopupSpawner.difficulty
	score_label.text = "Score: %d" % int(score)

func _exit_tree() -> void:
	if score > high_score:
		high_score = score
		var file = FileAccess.open("Highscore.sav", FileAccess.WRITE)
		file.store_32(high_score)
		file.close()
