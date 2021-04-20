extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

class_name StoreMenuButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _pressed():
	var parentIndex = get_index()
	var parent = get_parent()
	if !parent.get_child(parentIndex+1) is ScrollContainer:
		var scrollContainer = ScrollContainer.new()
		
		var equip = Armor.new().get_data()
		print(equip)
		
		for item in equip:
			print(equip[item]["name"])
			#print(item["name"])
			var btn = Button.new()
			btn.set_size(Vector2(100,80))
			btn.text = equip[item]["name"]
			scrollContainer.add_child(btn)
		scrollContainer.set_size(Vector2(100,equip.size()*80))
		add_child_below_node(self,scrollContainer)
		#add_child(scrollContainer)
		#add_child_below_node(self,scrollContainer)
