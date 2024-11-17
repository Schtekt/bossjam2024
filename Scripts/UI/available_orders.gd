extends CanvasLayer

class_name Available_Orders

signal make_dish(type: Recipe_Base)

func set_available_orders(orders: Array[Recipe_Base]):
	var vBoxNode: VBoxContainer = get_node("VBoxContainer")

	for child in vBoxNode.get_children():
		child.queue_free()

	for order: Recipe_Base in orders:
		var order_sprite := Order_Factory.create_order(order.output)
		var tBtn := TextureButton.new()
		tBtn.texture_normal = order_sprite.texture
		tBtn.size_flags_horizontal = Control.SIZE_EXPAND


		tBtn.pressed.connect(func(): make_dish.emit(order))
		vBoxNode.call_deferred("add_child", tBtn)
