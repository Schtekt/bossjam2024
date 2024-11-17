extends Node

static var cream_scene: PackedScene = preload("res://Scenes/Dishes/Cream.tscn")

static func create_item(type: Dish_Base.Dish_Type) -> Dish_Base:
	if type == Dish_Base.Dish_Type.CREAM:
		var node: Dish_Base = cream_scene.instantiate()
		node.dish_type = Dish_Base.Dish_Type.CREAM
		node.delivery_reward = 1
		return node
	return null
