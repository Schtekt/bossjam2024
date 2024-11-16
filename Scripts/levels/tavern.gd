extends Node2D
class_name Tavern

signal exit_tavern()

func _verify_and_exit_tavern(body: Node2D):
	if(body == get_node("Player")):
		exit_tavern.emit()

func _ready() -> void:
	var exit_node: Area2D = get_node("Exit")
	exit_node.body_entered.connect(_verify_and_exit_tavern)

func _process(_delta: float) -> void:
	pass
