extends Item_Base

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.food_type = Food_Type.MOLDY_CREAM

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for body in self.get_overlapping_bodies():
		body.emit_signal("item_pickup", self)
