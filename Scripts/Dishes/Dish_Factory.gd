extends Node

class_name Dish_Factory

const cream_scene: PackedScene = preload("res://Scenes/Dishes/Cream.tscn")
const glazed_donut_scene: PackedScene = preload("res://Scenes/Dishes/Glazed_Donut.tscn")

static func create_dish(type: Dish_Base.Dish_Type) -> Dish_Base:
	var node: Dish_Base = null
	if type == Dish_Base.Dish_Type.CREAM:
		node = cream_scene.instantiate()
		node.delivery_reward = 1
	elif type == Dish_Base.Dish_Type.GLAZED_DONUT:
		node = glazed_donut_scene.instantiate()
		node.delivery_reward = 2

	if node != null:
		node.dish_type = type
	
	return node
