extends Node

static var cream_scene: PackedScene = preload("res://Scenes/Dishes/Cream.tscn")

static func create_item(type: Dish_Base.Dish_Type) -> Dish_Base:
	if type == Dish_Base.Dish_Type.CREAM:
		return cream_scene.instantiate()
	return null
