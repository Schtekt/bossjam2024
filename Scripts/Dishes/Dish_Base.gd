extends Area2D
class_name Dish_Base

enum Dish_Type{CREAM}
var dish_type: Dish_Type
var delivery_reward: int

func _on_body_enter(body: Node2D) -> void:
	body.emit_signal("dish_collide", self)

func _ready() -> void:
	body_entered.connect(_on_body_enter)
