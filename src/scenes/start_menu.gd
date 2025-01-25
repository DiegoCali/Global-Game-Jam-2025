extends Control

signal game_start
signal restart
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("RESTART"):
		restart.emit()
		self.show()

func _on_button_pressed() -> void:
	game_start.emit()
	self.hide()
