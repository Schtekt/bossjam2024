extends StaticBody2D

var chair_scene = preload("res://Scenes/Levels/Tavern/Chair.tscn")

var chairs_at_table = 0

var current_order: Array[Dish_Base.Dish_Type]

func _create_left_chair() -> void:
	var chair: Chair = chair_scene.instantiate()
	chair.set_direction(Chair.Chair_Direction.RIGHT)
	self.call_deferred("add_child", chair)
	var tileMapLayer: TileMapLayer = get_node("TileMapLayer")
	chair.position.x -= tileMapLayer.get_used_rect().size.x * tileMapLayer.rendering_quadrant_size

func _create_right_chair() -> void:
	var chair: Chair = chair_scene.instantiate()
	chair.set_direction(Chair.Chair_Direction.LEFT)
	self.call_deferred("add_child", chair)
	var tileMapLayer: TileMapLayer = get_node("TileMapLayer")
	chair.position.x += tileMapLayer.get_used_rect().size.x * tileMapLayer.rendering_quadrant_size

func _generate_orders() -> void:
	for i in range(chairs_at_table):
		current_order.append(randi() % Dish_Base.Dish_Type.size())
	
	var order_indicator_node: Order_Indicator = get_node("Order-Indicator")
	order_indicator_node.visible = true
	for order in current_order:
		order_indicator_node.add_order(order)

func randomize_chairs() -> void:
	self.chairs_at_table = (randi() % 2) + 1
	
	var available_chair_placements = [Chair.Chair_Direction.LEFT, Chair.Chair_Direction.RIGHT]

	for i in range(self.chairs_at_table):
		var chair_placement = randi() % available_chair_placements.size()
		var chair = available_chair_placements[chair_placement]
		available_chair_placements.erase(chair_placement)
		if chair == Chair.Chair_Direction.LEFT:
			_create_right_chair()
		elif chair == Chair.Chair_Direction.RIGHT:
			_create_left_chair()

func _ready() -> void:
	randomize_chairs()
	_generate_orders()
