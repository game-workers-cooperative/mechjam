extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int) var id

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.store['bought']['armor'][id]:
		self.text = "Bought"
		self.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
