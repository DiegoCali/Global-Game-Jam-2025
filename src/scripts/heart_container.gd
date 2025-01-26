extends Control

signal game_over
var lives = 3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(lives):
		var NewHeart = Label.new()
		NewHeart.set_text("<3")
		$HeartContainer.add_child(NewHeart)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if lives <= 0:
		game_over.emit()

func reduce_heart():
	lives = lives - 1

func reset():
	lives = 3
