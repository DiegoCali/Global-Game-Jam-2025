extends Control

@export var bubble_scene : PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var starmenu = $StartMenu
	starmenu.show()
	$Hud.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_game():
	$Hud.show()
	$GameTimer.start()
func _on_game_timer_timeout() -> void:
	var bubble = bubble_scene.instantiate()
	bubble.connect("popped", add_point_to_hud())
	var bubble_spawn_location = $BubblePath/FollowBubblePath
	bubble_spawn_location.progress_ratio = randf()
	
	# Set the mob's direction perpendicular to the path direction.
	var direction = bubble_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	bubble.position = bubble_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	bubble.rotation = direction

	# Spawn the mob by adding it to the Main scene.
	add_child(bubble)

func add_point_to_hud():
	$Hud/HBoxContainer/PointsContainer.add_point()
