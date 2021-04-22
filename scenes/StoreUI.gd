extends Node

func _ready():
	pass # Replace with function body.

onready var global = get_node("/root/Global")

func _clear_store():
	for child in $StoreMarginContainer.get_children():
		$StoreMarginContainer.remove_child(child)

func _equip_button_pressed(name,type):
	global.store['equipped'][type] = name
	_populate_store(type)

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
		"leg":
			data = Legs.new()
			store = global.store["bought"]["legs"]
	equipment = data.get_data()
	stats = data.stats
	statBlock = data.STATVALUES.keys()
	for i in range(equipment.size()):
		var equipLabel = RichTextLabel.new()
		equipLabel.rect_min_size = Vector2(600,60)
		var equip = equipment.get(str(i))
		var itemButton = Button.new()
		itemButton.rect_size = Vector2(80,20)
		itemButton.rect_min_size = Vector2(80,20)
		itemButton.set_size(Vector2(80,20),true)
		
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
			#textblock+= "Purchased"
			if global.store['equipped'][type] == equip.get('name'):
				itemButton.text = "Item Equipped"
				itemButton.disabled = true
			else:
				itemButton.text = "Equip Purchased Item"
			equipLabel.text = textblock
			$StoreMarginContainer.add_child(equipLabel)
			itemButton.connect("pressed",self,"_equip_button_pressed",[equip.get('name'),type])
		else:
			itemButton.text = "Buy for "+str(equip.get("cost"))
			equipLabel.text = textblock
			$StoreMarginContainer.add_child(equipLabel)
			itemButton.connect("pressed",self,"_buy_button_pressed",[store,i,type])
		$StoreMarginContainer.add_child(itemButton)

func _on_CockpitButton_pressed():
	_populate_store("cockpit")

func _on_ArmorButton_pressed():
	_populate_store("armor")

func _on_WeaponButton_pressed():
	_populate_store("weapon")

func _on_LegsButton_pressed():
	_populate_store("leg")
