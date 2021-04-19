extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(int) var price

func _ready():
	text = str(price)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
