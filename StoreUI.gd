extends Node

func _ready():
	pass # Replace with function body.

onready var global = get_node("/root/Global")

func _clear_store():
	for child in $StoreMarginContainer.get_children():
		$StoreMarginContainer.remove_child(child)

func _buy_button_pressed(store,equip,type):
	store[equip] = true
	_populate_store(type)
	
func _populate_store(type):
	_clear_store()
	var equipment
	var store
	var stats
	var statBlock
	var data
	match type:
		"cockpit":
			data = Cockpits.new()
			store = global.store["bought"]["cockpits"]
		"armor":
			data = Armors.new()
			store = global.store["bought"]["armors"]
		"weapon":
			data = Weapons.new()
			store = global.store["bought"]["weapons"]
		"legs":
			data = Legs.new()
			store = global.store["bought"]["legs"]
	equipment = data.get_data()
	stats = data.stats
	statBlock = data.STATVALUES.keys()
	for i in range(equipment.size()):
		var equipLabel = RichTextLabel.new()
		equipLabel.rect_min_size = Vector2(600,60)
		var equip = equipment.get(str(i))
		var buyButton = Button.new()
		buyButton.rect_size = Vector2(80,20)
		buyButton.rect_min_size = Vector2(80,20)
		buyButton.set_size(Vector2(80,20),true)
		buyButton.connect("pressed",self,"_buy_button_pressed",[store,i,type])
		var textblock = ""
		textblock+= equip.get("name")+"\n"
		textblock+= "Stats:\n"
		for statndx in range(stats.size()):
			textblock+= stats[statndx].capitalize()
			textblock+=  ": "
			textblock+= statBlock[equip.get(stats[statndx])]
			textblock+=  "    "
			if statndx+1 % 4 == 0 and statndx < stats.size():
				textblock+= "\n"
		if store[i]:
			textblock+= "Purchased"
			equipLabel.text = textblock
			$StoreMarginContainer.add_child(equipLabel)
		else:
			buyButton.text = "Buy for "+str(equip.get("cost"))
			equipLabel.text = textblock
			$StoreMarginContainer.add_child(equipLabel)
			$StoreMarginContainer.add_child(buyButton)

func _on_CockpitButton_pressed():
	_populate_store("cockpit")

func _on_ArmorButton_pressed():
	_populate_store("armor")

func _on_WeaponButton_pressed():
	_populate_store("weapon")

func _on_LegsButton_pressed():
	_populate_store("legs")
