extends NinePatchRect

class_name Order_Indicator

var order_types: Array[Dish_Base.Dish_Type]

func visual_sort_orders():
	if get_child_count() == 0:
		hide()

	var children_width = 0
	var half_height = size.y / 2
	for child: Sprite2D in get_children():
		child.position.x = children_width + patch_margin_left * 4
		child.position.y = half_height
		children_width += child.get_rect().size.x

	size.x = children_width + patch_margin_left * 4

func add_order(type: Dish_Base.Dish_Type) -> void:
	var order_node: Sprite2D = Order_Factory.create_order(type)
	order_types.append(type)
	order_node.call_deferred("reparent", self)
	self.call_deferred("visual_sort_orders")

func remove_order(type: Dish_Base.Dish_Type) -> bool:
	var index = 0
	for stored_type in self.order_types:
		if stored_type == type:
			self.order_types.erase(stored_type)
			self.call_deferred("remove_child", self.get_children()[index])
			self.call_deferred("visual_sort_orders")
			return true
		index += 1
	return false
