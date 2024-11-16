extends Area2D

class_name Chair

enum Chair_Direction{LEFT, RIGHT}

func set_direction(dir: Chair_Direction) -> void:
	var left_chair: Node2D = get_node("LeftFacing")
	var right_chair: Node2D = get_node("RightFacing")

	if dir == Chair_Direction.LEFT:
		left_chair.visible = true
		right_chair.visible = false
	else:
		left_chair.visible = false
		right_chair.visible = true

func _ready() -> void:
	pass
