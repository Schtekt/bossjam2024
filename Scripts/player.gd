extends CharacterBody2D


const SPEED = 7500.0


func _physics_process(delta: float) -> void:

	var hor_direction := Input.get_axis("ui_left", "ui_right")
	var vert_direction := Input.get_axis("ui_up", "ui_down")
	velocity = Vector2(hor_direction, vert_direction) * SPEED * delta

	move_and_slide()
