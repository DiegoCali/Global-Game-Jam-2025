extends Node2D

@export var vx = 50
@export var vy = 50
var velocity = Vector2(0,0)
var rng = RandomNumberGenerator.new()
var IamBad = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = Vector2(vx, vy)
	IamBad = rng.randi() % 2 == 0
	if not IamBad:
		$AnimatedSprite2D.play("good_static")
	else:
		$AnimatedSprite2D.play("bad_static")
		$AnimatedSprite2D.set_scale(Vector2(0.32, 0.32))
	$Area2D.connect("input_event", self._on_area2d_input_event)
	print(velocity)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += velocity * delta

func _on_area2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if not IamBad:
			$AnimatedSprite2D.play("pop_good")
			$AnimatedSprite2D.set_scale(Vector2(0.3, 0.3))
		else:
			$AnimatedSprite2D.play("pop_bad")


func _on_animated_sprite_2d_animation_finished() -> void:
	print("Goodbye")
	queue_free()
