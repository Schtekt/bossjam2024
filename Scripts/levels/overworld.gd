extends Node2D

const enemy_scene := preload("res://Scenes/characters/Enemy.tscn")
var enemy_spawn_points: Array[Vector2] = []

func _ready() -> void:
	var spawn_points = get_node("Spawn points")

	# no point in further spawn point logic if there isn't any
	if spawn_points.get_children().size() == 0:
		return

	for child in spawn_points.get_children():
		if child is Marker2D:
			var marker: Marker2D = child
			enemy_spawn_points.append(marker.position)

	var nr_of_enemies_to_spawn = max(1, randi() % enemy_spawn_points.size())

	for i in range(nr_of_enemies_to_spawn):
		var new_enemy: Enemy = enemy_scene.instantiate()
		var sp_index = randi() % enemy_spawn_points.size()
		new_enemy.position = enemy_spawn_points[sp_index]
		enemy_spawn_points.remove_at(sp_index)
		var vert_or_hor: bool = randi() % 2
		var reverse_dir = ((randi() % 2) - 0.5) * 2

		new_enemy.set_direction(Vector2((1 if vert_or_hor else 0) * reverse_dir, (0 if vert_or_hor else 1) * reverse_dir))

		self.add_child(new_enemy)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
