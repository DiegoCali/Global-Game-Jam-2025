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
	if lives > 0:
		lives = lives - 1
		if $HeartContainer.get_child_count() > 0:
			$HeartContainer.get_child($HeartContainer.get_child_count() - 1).queue_free()
			
func clear_children():
	for child in $HeartContainer.get_children():
		child.queue_free()

func reset():
	lives = 3
	$HeartContainer.clear_children()
	for i in range(lives):
		var NewHeart = Label.new()
		NewHeart.set_text("<3")
		$HeartContainer.add_child(NewHeart)
