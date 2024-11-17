extends Node2D
class_name Tavern

signal exit_tavern()
signal update_inventory(inventory: Dictionary)
signal update_gold(gold: int)

var player_by_oven = false

@export var cookbook: Array[Recipe_Base]

func _verify_and_exit_tavern(body: Node2D):
	var player_node: Player = get_node("Player")
	if body == player_node:
		update_inventory.emit(player_node.backpack)
		update_gold.emit(player_node.gold)
		exit_tavern.emit()

func _verify_and_set_player_by_oven(body: Node2D):
	var player_node: Player = get_node("Player")
	if(body == player_node):
		var oven_node: Oven = get_node("Oven")
		player_by_oven = true
		oven_node.change_oven_state(player_by_oven)

		var available_orders_node: Available_Orders = get_node("Available_Orders")
		available_orders_node.set_available_orders(get_possible_recipes(cookbook, player_node.backpack))

func _verify_and_set_player_exit_oven(body: Node2D):
	if(body == get_node("Player")):
		var oven_node: Oven = get_node("Oven")
		player_by_oven = false
		oven_node.change_oven_state(player_by_oven)
		var available_orders_node: Available_Orders = get_node("Available_Orders")
		available_orders_node.set_available_orders([])

func _spawn_dish(type: Dish_Base.Dish_Type) -> void:
	var dish: Dish_Base = Dish_Factory.create_dish(type)
	var player_node: Player = get_node("Player")
	dish.position = player_node.position
	call_deferred("add_child", dish)

func _create_dish(recipe: Recipe_Base) -> void:
	var player_node: Player = get_node("Player")
	if player_node.backpack.is_empty():
		return

	# Verify that recipe can be made
	for entry in recipe.required_input:
		if player_node.backpack[entry.type] < entry.count:
			return

	# remove required input from inventory
	for entry in recipe.required_input:
		player_node.backpack[entry.type] -= entry.count

	_spawn_dish(recipe.output)

	if player_by_oven:
		var available_orders_node: Available_Orders = get_node("Available_Orders")
		available_orders_node.set_available_orders(get_possible_recipes(cookbook, player_node.backpack))


func get_possible_recipes(recipe_collection: Array[Recipe_Base], inventory: Dictionary) -> Array[Recipe_Base]:
	var res: Array[Recipe_Base] = []
	if inventory.is_empty() or recipe_collection.is_empty():
		return res

	for recipe in recipe_collection:
		var recipe_viable = true

		for input_entry in recipe.required_input:
			if not inventory.has(input_entry.type) or inventory[input_entry.type] < input_entry.count:
				recipe_viable = false
				break

		if recipe_viable:
			res.append(recipe)
	return res

func _ready() -> void:
	var exit_node: Area2D = get_node("Exit")
	exit_node.body_entered.connect(_verify_and_exit_tavern)

	var oven_node: Oven = get_node("Oven")
	oven_node.body_entered.connect(_verify_and_set_player_by_oven)
	oven_node.body_exited.connect(_verify_and_set_player_exit_oven)

	var player_node: Player = get_node("Player")

	for child in get_children():
		if child is Table:
			var table: Table = child
			table.dish_delivered.connect(player_node.receive_reward.emit)
	var persistent_ui_node: Persistent_UI = get_node("Persistent_UI")
	player_node.gold_updated.connect(persistent_ui_node.update_coins.emit)

	persistent_ui_node.update_coins.emit(player_node.gold)

	var available_orders_node: Available_Orders = get_node("Available_Orders")
	available_orders_node.make_dish.connect(_create_dish)
