extends CharacterBody2D

const SPEED = 200.0

signal enemy_collision(enemy_node: Enemy, damage: float)

func _ready():
	self.connect("enemy_collision", _on_enemy_collision)

func _physics_process(_delta: float) -> void:
	var hor_direction := Input.get_axis("ui_left", "ui_right")
	var vert_direction := Input.get_axis("ui_up", "ui_down")
	velocity = Vector2(hor_direction, vert_direction) * SPEED

	move_and_slide()

func _on_enemy_collision(enemy_node: Enemy, damage: float) -> void:
	print("Collided with enemy that made %f damage" %damage)
	enemy_node.emit_signal("player_was_hit")
