extends Node2D

const overworld_scene = preload("res://Scenes/Levels/Overworld/Overworld.tscn")
const tavern_scene = preload("res://Scenes/Levels/Tavern/Tavern.tscn")

func _clear_children() -> void:
	for child in get_children():
		child.queue_free()

func _set_tavern_active() -> void:
	_clear_children()

	var tavern: Tavern = tavern_scene.instantiate()
	self.call_deferred("add_child", tavern)

func _set_overworld_active() -> void:
	_clear_children()

	var overworld: Overworld = overworld_scene.instantiate()
	overworld.enter_tavern.connect(_set_tavern_active)
	self.call_deferred("add_child", overworld)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_overworld_active()
