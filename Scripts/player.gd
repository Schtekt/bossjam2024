extends CharacterBody2D
const SPEED = 300.0

func _physics_process(delta: float) -> void:
	var horizontal_direction := Input.get_axis("ui_left", "ui_right")
	var vertical_direction := Input.get_axis("ui_up", "ui_down")

	self.velocity.x = horizontal_direction * SPEED
	self.velocity.y = vertical_direction * SPEED

	move_and_collide(self.velocity * delta)
