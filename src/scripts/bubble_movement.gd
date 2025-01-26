extends Node2D

var velocity = Vector2(50, 50)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D.connect("input_event", self._on_area2d_input_event)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += velocity * delta

func _on_area2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		queue_free()


func _on_animated_sprite_2d_animation_finished() -> void:
	print("Goodbye")
	popped.emit(IamBad)
	queue_free()
	
