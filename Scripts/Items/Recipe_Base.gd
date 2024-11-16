extends Resource
class_name Recipe_Base

# Dictionary type: key = Food_Type, value = int
@export var required_input: Array[Recipe_Entry]

@export var output: Dish_Base.Dish_Type
