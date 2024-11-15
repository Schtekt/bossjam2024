extends CharacterBody2D

class_name Enemy

const SPEED = 100.0

var dmg = 1.0

var cooldown_timer: Timer
var may_attack = true
var dir: Vector2

signal collided(damage: float)

func set_direction(dir: Vector2) -> void:
	self.velocity = dir.normalized() * SPEED

func _ready() -> void:
	cooldown_timer = Timer.new()
	self.add_child(cooldown_timer)
	cooldown_timer.connect("timeout", func(): self.may_attack = true)

func _physics_process(delta: float) -> void:
	if move_and_slide():
		var last_collision = get_last_slide_collision()
		self.velocity = last_collision.get_normal() * SPEED

		if self.may_attack:
			last_collision.get_collider().emit_signal("enemy_collision", self.dmg)

			# Use a cooldown timer on attacks to not overwhelm any player with
			# damage in case they get stuck in a collision with an enemy
			may_attack = false
			cooldown_timer.start(0.2)
