extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
onready var global = get_node("/root/Global")

func _buy_button_pressed(type,equip):
	var store
	match type:
		"cockpit":
			pass
		"armor":
			store = global.store["bought"]["armor"]
		"weapon":
			pass
		"legs":
			pass
	store[equip] = true
	for child in $StoreMarginContainer.get_children():
		$StoreMarginContainer.remove_child(child)
	_populate_store(type)
	
func _populate_store(type):
	var equipment
	var store
	var stats
	match type:
		"cockpit":
			pass
		"armor":
			var armor = Armor.new()
			equipment = armor.get_data()
			stats = armor.stats
			store = global.store["bought"]["armor"]
		"weapon":
			pass
		"legs":
			pass
	for i in range(equipment.size()):
		var equipLabel = RichTextLabel.new()
		equipLabel.rect_min_size = Vector2(600,60)
		var equip = equipment.get(str(i))
		var buyButton = Button.new()
		buyButton.rect_size = Vector2(80,20)
		buyButton.rect_min_size = Vector2(80,20)
		buyButton.set_size(Vector2(80,20),true)
		buyButton.connect("pressed",self,"_buy_button_pressed",[type,i])
		var textblock = ""
		textblock+= equip.get("name")+"\n"
		textblock+= "Stats:\n"
		for statndx in range(stats.size()):
			textblock+= stats[statndx].capitalize()
			textblock+=  ": "
			textblock+= Armor.STATVALUES.keys()[equip.get(stats[statndx])]
			textblock+=  "    "
			if statndx+1 % 4 == 0 and statndx < stats.size():
				textblock+= "\n"
			#if statndx < stats.size():
			#	textblock+= "\n"
		if store[i]:
			textblock+= "Purchased"
			equipLabel.text = textblock
			$StoreMarginContainer.add_child(equipLabel)
		else:
			buyButton.text = "Buy for "+str(equip.get("cost"))
			equipLabel.text = textblock
			$StoreMarginContainer.add_child(equipLabel)
			$StoreMarginContainer.add_child(buyButton)
		
	#$MarginContainer/StoreTextLabel.text = textblock
		

func _on_CockpitButton_pressed():
	_populate_store("cockpit")

func _on_ArmorButton_pressed():
	_populate_store("armor")

func _on_WeaponButton_pressed():
	_populate_store("weapon")

func _on_LegsButton_pressed():
	_populate_store("legs")
