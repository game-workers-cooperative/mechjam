extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var armorTypes = ['Carbon Nanotech','Steel','Ceramic','Radioactive Waste','Alien Hardwood','Rubber']

# Called when the node enters the scene tree for the first time.
func _ready():
	for armor in armorTypes:
		var button = Button.new()
		button.text = armor
		add_child(button)
		button.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
