extends Node

const moldy_cream_scene: PackedScene = preload("res://Scenes/Items/Moldy_cream.tscn")
const donut_scene: PackedScene = preload("res://Scenes/Items/Donut.tscn")

static func create_item(food_type: Item_Base.Food_Type) -> Item_Base:
	var item_node: Item_Base = null

	if food_type == Item_Base.Food_Type.MOLDY_CREAM:
		item_node = moldy_cream_scene.instantiate()
	elif food_type == Item_Base.Food_Type.DONUT:
		item_node = donut_scene.instantiate()


	item_node.food_type = food_type
	return item_node
