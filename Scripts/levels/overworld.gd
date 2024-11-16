extends Node2D

class_name Overworld

signal enter_tavern()

const enemy_scene := preload("res://Scenes/characters/Enemy.tscn")
const item_factory := preload("res://Scripts/Items/Item_Factory.gd")
var spawn_points: Array[Vector2] = []

func _spawn_enemy(pos: Vector2) -> void:
	var new_enemy: Enemy = enemy_scene.instantiate()
	new_enemy.position = pos
	var vert_or_hor: bool = randi() % 2
	var reverse_dir = ((randi() % 2) - 0.5) * 2
	new_enemy.set_direction(Vector2((1 if vert_or_hor else 0) * reverse_dir, (0 if vert_or_hor else 1) * reverse_dir))
	new_enemy.enemy_dead.connect(_on_enemy_dead)
	self.call_deferred("add_child", new_enemy)

func _spawn_random_item(pos: Vector2) -> void:
	var new_item: Item_Base = item_factory.create_item(randi() % Item_Base.Food_Type.size())
	new_item.position = pos

	self.call_deferred("add_child", new_item)

func _on_enemy_dead(enemy: Enemy):
	var enemy_pos = enemy.position
	enemy.queue_free()
	_spawn_random_item(enemy_pos)

func _verify_and_enter_tavern(body: Node2D):
	if body == self.get_node("Player"):
		enter_tavern.emit()

func _ready() -> void:
	var tavern_door_node: Area2D = get_node("TavernDoor")
	tavern_door_node.body_entered.connect(_verify_and_enter_tavern)
	var spawn_points_node = get_node("Spawn points")

	# no point in further spawn point logic if there isn't any
	if spawn_points_node.get_children().size() == 0:
		return

	for child in spawn_points_node.get_children():
		if child is Marker2D:
			var marker: Marker2D = child
			spawn_points.append(marker.position)

	var nr_of_enemies_to_spawn = max(1, randi() % spawn_points.size())
	var nr_of_items_to_spawn = spawn_points.size() - nr_of_enemies_to_spawn - 1

	for i in range(nr_of_enemies_to_spawn):
		var sp_index = randi() % spawn_points.size()
		self._spawn_enemy(spawn_points[sp_index])
		spawn_points.remove_at(sp_index)

	for i in range(nr_of_items_to_spawn):
		var sp_index = randi() % spawn_points.size()
		self._spawn_random_item(spawn_points[sp_index])
		spawn_points.remove_at(sp_index)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
