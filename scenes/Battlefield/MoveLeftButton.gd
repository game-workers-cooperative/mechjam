extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# called when the button is clicked
func _pressed():
	var player = self.get_parent().player
	var position = Vector3(-1, 0, 0)
	player.try_move(position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
