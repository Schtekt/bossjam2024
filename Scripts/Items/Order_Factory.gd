extends Node

class_name Order_Factory

const cream_scene = preload("res://Scenes/Orders/Cream.tscn")

static func create_order(type: Dish_Base.Dish_Type) -> Sprite2D:
	if type == Dish_Base.Dish_Type.CREAM:
		return cream_scene.instantiate()
	return null
