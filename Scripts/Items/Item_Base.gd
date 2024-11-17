extends Area2D

class_name Item_Base

enum Food_Type {MOLDY_CREAM, DONUT}

var food_type: Food_Type

func _process(_delta: float) -> void:
	for body in self.get_overlapping_bodies():
		body.emit_signal("item_pickup", self)
