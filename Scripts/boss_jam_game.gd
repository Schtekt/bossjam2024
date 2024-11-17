extends Node2D

const overworld_scene = preload("res://Scenes/Levels/Overworld/Overworld.tscn")
const tavern_scene = preload("res://Scenes/Levels/Tavern/Tavern.tscn")

var latest_inventory: Dictionary = {}
var latest_gold_count: int = 0

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
	self.call_deferred("add_child", tavern)

func _set_overworld_active() -> void:
	_clear_children()

	var overworld: Overworld = overworld_scene.instantiate()
	overworld.enter_tavern.connect(_set_tavern_active)
	overworld.update_inventory.connect(func(inventory: Dictionary): self.latest_inventory = inventory)
	overworld.update_gold.connect(func(gold: int): self.latest_gold_count = gold)
	var player_node: Player = overworld.get_node("Player")
	player_node.backpack = latest_inventory
	player_node.gold = latest_gold_count
	self.call_deferred("add_child", overworld)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_overworld_active()
