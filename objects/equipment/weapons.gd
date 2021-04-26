extends Control
enum STATVALUES {KINETIC,ENERGY,SLASHING,MELEE,FIRE}
var stats =["damage"]
var _data :={
	"0": {
		"name":"Gun Type Weapon",
		"damage":STATVALUES.KINETIC,
		"range":10,
		"spread":1,
		"hitPercent":.9,
		"damageAmount":20,
		"cost":50
	},
	"1": {
		"name":"Energy Type weapon",
		"damage":STATVALUES.ENERGY,
		"range":10,
		"spread":1,
		"hitPercent":1,
		"damageAmount":25,
		"cost":150
	},
	"2": {
		"name":"Saw Weapon",
		"damage":STATVALUES.SLASHING,
		"range":1,
		"spread":2,
		"hitPercent":1,
		"damageAmount":55,		
		"cost":100
	},	
	"3": {
		"name":"Melee Weapon",
		"damage":STATVALUES.MELEE,
		"range":1,
		"spread":1,
		"hitPercent":1,
		"damageAmount":40,		
		"cost":0
	},
	"4": {
		"name":"FlameThrower",
		"damage":STATVALUES.FIRE,
		"range":3,
		"spread":2,
		"hitPercent":1,
		"damageAmount":60,		
		"cost":500
	},
}
var default = {
	"name":"Default",
	"damage":STATVALUES.MELEE,
	"range":1,
	"spread":1,
	"hitPercent":1,
	"damageAmount":1,		
	"cost":0
}
var dictionary : Dictionary
var json

class_name Weapons

func _ready():
	pass
	
func find(text):
	for n in _data:
		if _data[n].get('name') == text:
			return _data[n]
			
	return default
			
func get_data():
	json = to_json(_data)
	dictionary = JSON.parse(json).result
	return dictionary

# gets a random item from the list that is afforable given the provided budget
func get_random(budget):
	var available = []
	for n in _data:
		if _data[n].cost <= budget:
			available.append(_data[n])
	
	return available[randi() % len(available)].name

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
