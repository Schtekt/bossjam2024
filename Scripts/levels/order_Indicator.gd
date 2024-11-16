extends NinePatchRect

class_name Order_Indicator

func visual_sort_orders():
	var children_width = 0
	var half_height = size.y / 2
	for child: Sprite2D in get_children():
		child.position.x = children_width + patch_margin_left * 4
		child.position.y = half_height
		children_width += child.get_rect().size.x

	size.x = children_width + patch_margin_left * 4
	
	

func add_order(type: Dish_Base.Dish_Type):
	var order_node: Sprite2D = Order_Factory.create_order(type)
	self.call_deferred("add_child", order_node)
	self.call_deferred("visual_sort_orders")
