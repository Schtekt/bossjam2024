extends CanvasLayer
class_name GameOver

func set_score(score: int) -> void:
	var score_label: Label = get_node("Score")
	score_label.text = "Your Score: " + str(score)
