extends Control

var points = 34
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	set_points()

func add_point():
	points = points + 1

func set_points():
	$HBoxContainer/Number.set_text(str(points))
