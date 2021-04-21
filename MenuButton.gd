extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _pressed():
	print("pressed")
func _toggled(button_pressed):
	var parentIndex = get_index()
	var parent = get_parent()
	print("test")
	if !parent.get_child(parentIndex+1) is ScrollContainer:
		var scrollContainer = ScrollContainer.new()
		var equipment = preload("res://objects/equipment/armor.gd")
		var equip = equipment.dictionary
		for item in equip:
			print(equip["name"])
			var btn = Button.new()
			btn.text = equip["name"]
			scrollContainer.add_child(btn)
		add_child_below_node(self,scrollContainer)
