extends Node2D

@export var vx = 50
@export var vy = 50
var velocity = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = Vector2(vx, vy)
	$AnimatedSprite2D.play("good_static")
	$Area2D.connect("input_event", self._on_area2d_input_event)
	print(velocity)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += velocity * delta

func _on_area2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		queue_free()
