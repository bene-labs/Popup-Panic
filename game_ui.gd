extends Node2D

@export var score_label : Label
@export var high_score_label : Label
@export var base_points_per_seconds := 5.0
var score = 0.0
static var high_score := 0


func _ready() -> void:
	high_score_label.text = "Highscore: %d" % int(high_score)


func _process(delta: float) -> void:
	score += base_points_per_seconds * delta * PopupSpawner.difficulty
	score_label.text = "Score: %d" % int(score)

func _exit_tree() -> void:
	if score > high_score:
		high_score = score
