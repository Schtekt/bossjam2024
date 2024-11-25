extends StaticBody2D

class_name Table

var chair_scene = preload("res://Scenes/Levels/Tavern/Chair.tscn")

var chairs_at_table = 0

var current_order: Array[Dish_Base.Dish_Type]

signal dish_collide(dish: Dish_Base)
signal dish_delivered(reward: int)

func _attempt_delivery(dish: Dish_Base) -> void:
	for order in current_order:
		if order == dish.dish_type:
			var order_indicator_node: Order_Indicator = get_node("Order_Indicator")
			if order_indicator_node.remove_order(dish.dish_type):
				current_order.erase(order)
				dish.queue_free()
				dish_delivered.emit(dish.delivery_reward)

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
	
	var order_indicator_node: Order_Indicator = get_node("Order_Indicator")
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
	dish_collide.connect(_attempt_delivery)
	randomize_chairs()
	_generate_orders()
