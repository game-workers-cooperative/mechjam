extends Control
enum STATVALUES {KINETIC,ENERGY,SLASHING,PIERCING,FIRE}
var stats =["damage"]
var _data :={
	"0": {
		"name":"Gun Type Weapon",
		"damage":STATVALUES.KINETIC,
		"range":10,
		"spread":1,
		"cost":10
	},
	"1": {
		"name":"Energy Type weapon",
		"damage":STATVALUES.ENERGY,
		"range":10,
		"spread":1,
		"cost":10
	},
	"2": {
		"name":"Saw Weapon",
		"damage":STATVALUES.SLASHING,
		"range":1,
		"spread":2,
		"cost":10
	},	
	"3": {
		"name":"Melee Weapon",
		"damage":STATVALUES.PIERCING,
		"range":1,
		"spread":1,
		"cost":10
	},
	"4": {
		"name":"FlameThrower",
		"damage":STATVALUES.FIRE,
		"range":3,
		"spread":2,
		"cost":10
	},
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
		else:
			return false
			
func get_data():
	json = to_json(_data)
	dictionary = JSON.parse(json).result
	return dictionary
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
