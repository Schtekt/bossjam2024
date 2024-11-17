extends CanvasLayer
class_name GameOver

func set_score(score: int) -> void:
	var score_label: Label = get_node("Score")
	score_label.text = "Your Score: " + str(score)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
