extends Node2D
class_name Tavern

signal exit_tavern()
signal make_food()
signal update_inventory(inventory: Dictionary)

var player_by_oven = false

@export var cookbook: Array[Recipe_Base]

func _verify_and_exit_tavern(body: Node2D):
	var player_node: Player = get_node("Player")
	if body == player_node:
		update_inventory.emit(player_node.backpack)
		exit_tavern.emit()

func _verify_and_set_player_by_oven(body: Node2D):
	if(body == get_node("Player")):
		var oven_node: Oven = get_node("Oven")
		player_by_oven = true
		oven_node.change_oven_state(player_by_oven)

func _verify_and_set_player_exit_oven(body: Node2D):
	if(body == get_node("Player")):
		var oven_node: Oven = get_node("Oven")
		player_by_oven = false
		oven_node.change_oven_state(player_by_oven)

func get_possible_recipe(recipe_collection: Array[Recipe_Base], inventory: Dictionary) -> Recipe_Base:
	if inventory.is_empty() or recipe_collection.is_empty():
		return null

	for recipe in recipe_collection:
		var recipe_viable = true

		for input_entry in recipe.required_input:
			if inventory[input_entry.type] < input_entry.count:
				recipe_viable = false
				break

		if recipe_viable:
			return recipe
	return null

func _ready() -> void:
	var exit_node: Area2D = get_node("Exit")
	exit_node.body_entered.connect(_verify_and_exit_tavern)

	var oven_node: Oven = get_node("Oven")
	oven_node.body_entered.connect(_verify_and_set_player_by_oven)
	oven_node.body_exited.connect(_verify_and_set_player_exit_oven)

	var player_node: Player = get_node("Player")
	make_food.connect(func(): print(get_possible_recipe(cookbook, player_node.backpack)))

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("make_food") and self.player_by_oven:
		make_food.emit()
