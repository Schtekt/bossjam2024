extends StaticBody2D

var chair_scene = preload("res://Scenes/Levels/Tavern/Chair.tscn")

var chairs_at_table = 0

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

func randomize_chairs() -> void:
	self.chairs_at_table = (randi() % 2) + 1
	
	var available_chair_placements = [Chair.Chair_Direction.LEFT, Chair.Chair_Direction.RIGHT]
	
	for i in range(self.chairs_at_table):
		var chair_placement = randi() % available_chair_placements.size()
		available_chair_placements.erase(chair_placement)
		if chair_placement == Chair.Chair_Direction.LEFT:
			_create_right_chair()
		elif chair_placement == Chair.Chair_Direction.RIGHT:
			_create_left_chair()

func _ready() -> void:
	randomize_chairs()
