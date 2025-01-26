extends Node2D

@export var velocity: Vector2 = Vector2.ZERO  # Velocidad inicial de la burbuja
var rng = RandomNumberGenerator.new()
var IamBad = false  # Define si es una burbuja "mala" o "buena"
signal popped  # Señal que se emite al destruir la burbuja


func _ready() -> void:
	# Determinar si es una burbuja "mala" o "buena"
	IamBad = rng.randi() % 2 == 0
	if not IamBad:
		$AnimatedSprite2D.play("good_static")
	else:
		$AnimatedSprite2D.play("bad_static")
		$AnimatedSprite2D.set_scale(Vector2(0.32, 0.32))

	# Conectar el evento de colisión con clics
	$Area2D.connect("input_event", self._on_area2d_input_event)

func _process(delta: float) -> void:
	# Actualiza la posición según la velocidad
	position += velocity * delta
	
func _on_area2d_input_event(viewport, event, shape_idx):
	# Detecta si se hace clic en la burbuja
	if event is InputEventMouseButton and event.pressed:
		popped.emit(IamBad)
		$Area2D.queue_free()
		if not IamBad:
			$AnimatedSprite2D.play("pop_good")
			$AnimatedSprite2D.set_scale(Vector2(0.3, 0.3))
		else:
			$AnimatedSprite2D.play("pop_bad")

func _on_animated_sprite_2d_animation_finished() -> void:
	# Una vez que se completa la animación de "pop", elimina la burbuja
	print("Goodbye")
	queue_free()
