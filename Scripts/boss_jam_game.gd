extends Node2D

const overworld_scene = preload("res://Scenes/Levels/Overworld/Overworld.tscn")
const tavern_scene = preload("res://Scenes/Levels/Tavern/Tavern.tscn")
const game_over_scene = preload("res://Scenes/Levels/Game over/Game_Over.tscn")

var latest_inventory: Dictionary = {}
var latest_gold_count: int = 0
var latest_health: int = Player.MAX_HEALTH

func _on_game_end() -> void:
	_clear_children()
	var game_over_node = game_over_scene.instantiate()
	self.call_deferred("add_child", game_over_node)


func _clear_children() -> void:
	for child in get_children():
		child.queue_free()

func _set_tavern_active() -> void:
	_clear_children()

	var tavern: Tavern = tavern_scene.instantiate()
	tavern.update_inventory.connect(func(inventory: Dictionary): self.latest_inventory = inventory)
	tavern.update_gold.connect(func(gold: int): self.latest_gold_count = gold)
	tavern.exit_tavern.connect(_set_overworld_active)
	var player_node: Player = tavern.get_node("Player")
	player_node.backpack = latest_inventory
	player_node.gold = latest_gold_count
	var health_bar_node: Control = player_node.get_node("HealthBar")
	health_bar_node.visible = false
	self.call_deferred("add_child", tavern)

func _set_overworld_active() -> void:
	_clear_children()

	var overworld: Overworld = overworld_scene.instantiate()
	overworld.enter_tavern.connect(_set_tavern_active)
	overworld.update_inventory.connect(func(inventory: Dictionary): self.latest_inventory = inventory)
	overworld.update_gold.connect(func(gold: int): self.latest_gold_count = gold)
	overworld.update_health.connect(func(health: int): self.latest_health = health)
	var player_node: Player = overworld.get_node("Player")
	player_node.backpack = latest_inventory
	player_node.gold = latest_gold_count
	player_node.health = latest_health
	player_node.player_dead.connect(_on_game_end)
	self.call_deferred("add_child", overworld)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_overworld_active()
