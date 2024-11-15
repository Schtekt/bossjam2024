extends Node2D

@export var time_in_a_day: int = 60 * 60 * 24

var CurrentTime: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CurrentTime = 0.0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	CurrentTime += delta
	
	
	pass