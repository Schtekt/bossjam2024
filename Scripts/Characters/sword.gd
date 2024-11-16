extends Area2D

class_name Sword

var attack_duration = 0.2 # seconds
var attack_duration_timer: Timer

func attack() -> void:
	var sprite: Sprite2D = get_node("Sprite2D")
	sprite.visible = true
	attack_duration_timer.start(attack_duration)
	
	self.monitoring = true

func _stop_attack() -> void:
	var sprite: Sprite2D = get_node("Sprite2D")
	sprite.visible = false
	self.monitoring = false


func _ready() -> void:
	attack_duration_timer = Timer.new()
	attack_duration_timer.timeout.connect(_stop_attack)
	self.add_child(attack_duration_timer)
	
	body_entered.connect(_enemy_entered)

	_stop_attack()

func _enemy_entered(body: Node2D) -> void:
	body.emit_signal("sword_attack", position, 1)
