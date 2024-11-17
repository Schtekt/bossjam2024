extends CharacterBody2D

class_name Player

const SPEED = 200.0

signal enemy_collision(enemy_node: Enemy, damage: int)
signal item_pickup(item_node: Item_Base)
signal dish_collide(order_base: Dish_Base)
signal receive_reward(reward: int)

var backpack: Dictionary
var held_dish: Dish_Base = null
var gold: int = 0
const MAX_HEALTH: int = 10
var health: int = 10

func _ready():
	# Food_Type, int
	enemy_collision.connect(_on_enemy_collision)
	item_pickup.connect(_on_item_pickup)
	dish_collide.connect(_on_dish_pickup)
	receive_reward.connect(_on_receive_reward)

	var health_bar_node: ProgressBar = get_node("HealthBar")
	health_bar_node.max_value = MAX_HEALTH
	health_bar_node.value = health

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

func _on_enemy_collision(enemy_node: Enemy, damage: int) -> void:
	enemy_node.emit_signal("player_was_hit")
	_update_health(health - damage)

func _on_item_pickup(item_node: Item_Base):
	if self.backpack.has(item_node.food_type):
		self.backpack[item_node.food_type] += 1
	else:
		self.backpack[item_node.food_type] = 1

	item_node.queue_free()

func _on_dish_pickup(dish_node: Dish_Base) -> void:
	if held_dish != null:
		return

	held_dish = dish_node
	dish_node.call_deferred("reparent", self)
	var sprite_node: Sprite2D = get_node("Sprite2D")
	var held_dish_sprite: Sprite2D = held_dish.get_node("Sprite2D")
	held_dish.position.y = self.position.y - sprite_node.get_rect().size.y
	held_dish.position.x = self.position.x + (sprite_node.get_rect().size.x / 2) - (held_dish_sprite.get_rect().size.x / 2) + 0.5

func _on_receive_reward(reward: int):
	gold += reward

func _update_health(new_health: int):
	health = new_health
	var health_bar_node: ProgressBar = get_node("HealthBar")
	health_bar_node.value = health