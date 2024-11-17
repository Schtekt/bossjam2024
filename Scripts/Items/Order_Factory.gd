extends Node

class_name Order_Factory

static func create_order(type: Dish_Base.Dish_Type) -> Sprite2D:
	var dish: Dish_Base = Dish_Factory.create_dish(type)

	if dish != null:
		var sprite_node = dish.get_node("Sprite2D")
		return sprite_node

	return null
