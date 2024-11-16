extends Area2D
class_name Oven

func change_oven_state(oven_on: bool) -> void:
	var on_sprite: AnimatedSprite2D = get_node("OvenOn")
	var off_sprite: Node2D = get_node("OvenOff")
	on_sprite.visible = oven_on
	off_sprite.visible = not oven_on

	if on_sprite.visible:
		on_sprite.play()
	else:
		on_sprite.stop()

func _ready() -> void:
	change_oven_state(false)
