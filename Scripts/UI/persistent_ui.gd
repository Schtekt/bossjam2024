extends CanvasLayer

class_name Persistent_UI

signal update_coins(coin_count: int)

func _on_update_coins(coin_count: int) -> void:
	var coin_count_node: Label = get_node("Coin_Count")
	coin_count_node.text = str(coin_count)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_coins.connect(_on_update_coins)
	pass
