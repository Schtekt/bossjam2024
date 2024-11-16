extends Node

static var moldy_cream_scene: PackedScene = preload("res://Scenes/Items/Moldy_cream.tscn")

static func create_item(food_type: Item_Base.Food_Type) -> Item_Base:
	if food_type == Item_Base.Food_Type.MOLDY_CREAM:
		return moldy_cream_scene.instantiate()
	return null
