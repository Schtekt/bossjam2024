extends Node2D
class_name Tavern

signal exit_tavern()

func _verify_and_exit_tavern(body: Node2D):
	if(body == get_node("Player")):
		exit_tavern.emit()

func _verify_and_set_player_by_oven(body: Node2D):
	if(body == get_node("Player")):
		var oven_node: Oven = get_node("Oven")
		oven_node.change_oven_state(true)

func _verify_and_set_player_exit_oven(body: Node2D):
	if(body == get_node("Player")):
		var oven_node: Oven = get_node("Oven")
		oven_node.change_oven_state(false)

func _ready() -> void:
	var exit_node: Area2D = get_node("Exit")
	exit_node.body_entered.connect(_verify_and_exit_tavern)

	var oven_node: Oven = get_node("Oven")
	oven_node.body_entered.connect(_verify_and_set_player_by_oven)
	oven_node.body_exited.connect(_verify_and_set_player_exit_oven)

func _process(_delta: float) -> void:
	pass
