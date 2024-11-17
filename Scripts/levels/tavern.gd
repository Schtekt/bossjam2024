extends Node2D
class_name Tavern

signal exit_tavern()
signal make_food()
signal update_inventory(inventory: Dictionary)
signal update_gold(gold: int)

var player_by_oven = false
var dish_factory = preload("res://Scripts/Dishes/Dish_Factory.gd")

@export var cookbook: Array[Recipe_Base]

func _verify_and_exit_tavern(body: Node2D):
	var player_node: Player = get_node("Player")
	if body == player_node:
		update_inventory.emit(player_node.backpack)
		update_gold.emit(player_node.gold)
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

func _spawn_dish(type: Dish_Base.Dish_Type) -> void:
	var dish: Dish_Base = dish_factory.create_item(type)
	var player_node: Player = get_node("Player")
	dish.position = player_node.position
	call_deferred("add_child", dish)

func _create_dish(recipe: Recipe_Base, inventory: Dictionary) -> void:
	if inventory.is_empty():
		return

	# Verify that recipe can be made
	for entry in recipe.required_input:
		if inventory[entry.type] < entry.count:
			return

	# remove required input from inventory
	for entry in recipe.required_input:
		inventory[entry.type] -= entry.count

	_spawn_dish(recipe.output)

func _cook_first_possible_dish() -> void:
	var player_node: Player = get_node("Player")
	var recipe = get_possible_recipe(cookbook, player_node.backpack)
	if recipe != null:
		_create_dish(recipe, player_node.backpack)

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

	make_food.connect(_cook_first_possible_dish)

	var player_node: Player = get_node("Player")

	for child in get_children():
		if child is Table:
			var table: Table = child
			table.dish_delivered.connect(player_node.receive_reward.emit)
	var persistent_ui_node: Persistent_UI = get_node("Persistent_UI")
	player_node.gold_updated.connect(persistent_ui_node.update_coins.emit)

	persistent_ui_node.update_coins.emit(player_node.gold)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("make_food") and self.player_by_oven:
		make_food.emit()
