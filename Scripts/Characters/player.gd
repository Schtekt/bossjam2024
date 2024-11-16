extends CharacterBody2D

const SPEED = 200.0

signal enemy_collision(enemy_node: Enemy, damage: float)
signal item_pickup(item_node: Item_Base)

var backpack: Dictionary

func _ready():
	# Food_Type, int
	enemy_collision.connect(_on_enemy_collision)
	item_pickup.connect(_on_item_pickup)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("player_attack"):
		var sword_node: Sword = get_node("Sword")
		var camera_node: Camera2D = get_node("Camera2D")
		var mouse_rel_pos = camera_node.get_local_mouse_position().normalized()
		sword_node.position = mouse_rel_pos * 10
		sword_node.attack()

func _physics_process(_delta: float) -> void:
	var hor_direction := Input.get_axis("ui_left", "ui_right")
	var vert_direction := Input.get_axis("ui_up", "ui_down")
	velocity = Vector2(hor_direction, vert_direction) * SPEED

	move_and_slide()

func _on_enemy_collision(enemy_node: Enemy, damage: float) -> void:
	print("Collided with enemy that made %f damage" %damage)
	enemy_node.emit_signal("player_was_hit")

func _on_item_pickup(item_node: Item_Base):
	if self.backpack.has(item_node.food_type):
		self.backpack[item_node.food_type] += 1
	else:
		self.backpack[item_node.food_type] = 1

	item_node.queue_free()
