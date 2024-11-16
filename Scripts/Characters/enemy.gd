extends CharacterBody2D

class_name Enemy

const SPEED = 100.0

var dmg = 1.0

var player_collided_cooldown_timer = 0.2
var cooldown_timer: Timer
var may_attack = true
var dir: Vector2

signal player_was_hit()

func set_direction(dir: Vector2) -> void:
	self.velocity = dir.normalized() * SPEED

func _ready() -> void:
	cooldown_timer = Timer.new()
	cooldown_timer.autostart = false
	self.add_child(cooldown_timer)
	cooldown_timer.connect("timeout", self._timeout)
	self.connect("player_was_hit", self._collided_with_player)

func _collided_with_player() -> void:
	self.may_attack = false
	self.cooldown_timer.start(self.player_collided_cooldown_timer)

func _timeout() -> void:
	self.may_attack = true

func _physics_process(_delta: float) -> void:
	if move_and_slide():
		var last_collision = get_last_slide_collision()
		self.velocity = last_collision.get_normal() * SPEED

		if self.may_attack:
			last_collision.get_collider().emit_signal("enemy_collision", self, self.dmg)
