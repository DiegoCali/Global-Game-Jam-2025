extends Control

@export var bubbles_scene : PackedScene
var score
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var starmenu = $StartMenu
	starmenu.show()
	$Hud.hide()
	$MenuMusic.play()
	$Hud/HBoxContainer/HeartContainer.connect("game_over", Callable(self,"gameover"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_game():
	$Hud.show()
	$GameTimer.start()
	$MenuMusic.stop()
	$InGameMusic.play()

func _on_game_timer_timeout() -> void:
	var bubble = bubbles_scene.instantiate()

	# Obtener los límites de la cámara
	var camera = $Camera2D
	var camera_rect = Rect2(
		camera.global_position - camera.zoom * camera.get_viewport_rect().size / 2,
		camera.zoom * camera.get_viewport_rect().size
	)

	# Generar una posición inicial fuera de los límites de la cámara
	var spawn_position = Vector2()
	var side = randi() % 4 # 0: izquierda, 1: derecha, 2: arriba, 3: abajo

	match side:
		0: # Izquierda
			spawn_position.x = camera_rect.position.x - 100
			spawn_position.y = randf_range(camera_rect.position.y, camera_rect.position.y + camera_rect.size.y)
		1: # Derecha
			spawn_position.x = camera_rect.position.x + camera_rect.size.x + 100
			spawn_position.y = randf_range(camera_rect.position.y, camera_rect.position.y + camera_rect.size.y)
		2: # Arriba
			spawn_position.x = randf_range(camera_rect.position.x, camera_rect.position.x + camera_rect.size.x)
			spawn_position.y = camera_rect.position.y - 100
		3: # Abajo
			spawn_position.x = randf_range(camera_rect.position.x, camera_rect.position.x + camera_rect.size.x)
			spawn_position.y = camera_rect.position.y + camera_rect.size.y + 100

	# Asignar posición inicial
	bubble.position = spawn_position

	# Calcular la dirección hacia el centro de la cámara
	var direction = (camera.global_position - spawn_position).normalized()

	# Agregar algo de aleatoriedad a la dirección
	direction = direction.rotated(randf_range(-PI / 8, PI / 8))

	# Configurar la velocidad de la burbuja
	bubble.velocity = direction * randf_range(50, 100) # Ajusta la velocidad según prefieras
	
	bubble.connect("popped", Callable(self,"_on_bubble_popped"))

	# Añadir la burbuja al árbol de nodos
	add_child(bubble)
	
func _on_bubble_popped(is_bad: bool) -> void:
	if not is_bad:
		add_point_to_hud()
	else:
		print("Burbuja mala explotada")
		$Hud/HBoxContainer/HeartContainer.reduce_heart() 

func add_point_to_hud():
	$Hud/HBoxContainer/PointsContainer.add_point()
	
func gameover() -> void:
	$Hud/HBoxContainer/HeartContainer.reset()
	$GameTimer.stop()
	$InGameMusic.stop()
	$GameOver.play()

func _on_game_over_finished() -> void:
	$MenuMusic.play()
	$StartMenu/VBoxContainer/Label.text = "Game Over"
	$StartMenu/VBoxContainer/Button.text = "restart"
	$StartMenu.show()
	
