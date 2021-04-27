extends Control
enum STATVALUES {IMMUNE,STRONG,NEUTRAL,WEAK,LIGHT,AVERAGE,HEAVY,TRUE,FALSE}
export var stats =["blade","fire","energy","bullet","melee","weight","radioactive","knockback"]
var _data :={
	"0": {
		"name":"Steel",
		"blade":STATVALUES.STRONG,
		"fire":STATVALUES.NEUTRAL,
		"energy":STATVALUES.WEAK,
		"bullet":STATVALUES.STRONG,
		"melee":STATVALUES.NEUTRAL,
		"weight":STATVALUES.HEAVY,
		"radioactive":STATVALUES.FALSE,
		"knockback":STATVALUES.FALSE,
		"cost":0
	},
	"1": {
		"name":"Carbon Nanotech",
		"blade":STATVALUES.WEAK,
		"fire":STATVALUES.STRONG,
		"energy":STATVALUES.STRONG,
		"bullet":STATVALUES.NEUTRAL,
		"melee":STATVALUES.NEUTRAL,
		"weight":STATVALUES.LIGHT,
		"radioactive":STATVALUES.FALSE,
		"knockback":STATVALUES.FALSE,
		"cost":0
	},
	"2": {
		"name":"Ceramic",
		"blade":STATVALUES.WEAK,
		"fire":STATVALUES.IMMUNE,
		"energy":STATVALUES.STRONG,
		"bullet":STATVALUES.WEAK,
		"melee":STATVALUES.WEAK,
		"weight":STATVALUES.AVERAGE,
		"radioactive":STATVALUES.FALSE,
		"knockback":STATVALUES.FALSE,
		"cost":500
	},	
	"3": {
		"name":"Alien Hardwood",
		"blade":STATVALUES.NEUTRAL,
		"fire":STATVALUES.WEAK,
		"energy":STATVALUES.NEUTRAL,
		"bullet":STATVALUES.NEUTRAL,
		"melee":STATVALUES.STRONG,
		"weight":STATVALUES.AVERAGE,
		"radioactive":STATVALUES.FALSE,
		"knockback":STATVALUES.FALSE,
		"cost":200
	},
	"4": {
		"name":"Radioactive Waste",
		"blade":STATVALUES.WEAK,
		"fire":STATVALUES.WEAK,
		"energy":STATVALUES.WEAK,
		"bullet":STATVALUES.WEAK,
		"melee":STATVALUES.WEAK,
		"weight":STATVALUES.WEAK,
		"radioactive":STATVALUES.TRUE,
		"knockback":STATVALUES.FALSE,
		"cost":1500
	},
	"5": {
		"name":"Rubber",
		"blade":STATVALUES.NEUTRAL,
		"fire":STATVALUES.NEUTRAL,
		"energy":STATVALUES.STRONG,
		"bullet":STATVALUES.WEAK,
		"melee":STATVALUES.STRONG,
		"weight":STATVALUES.AVERAGE,
		"radioactive":STATVALUES.FALSE,
		"knockback":STATVALUES.TRUE,
		"cost":750
	},
}
var default = {
	"name":"Default",
	"blade":STATVALUES.NEUTRAL,
	"fire":STATVALUES.NEUTRAL,
	"energy":STATVALUES.NEUTRAL,
	"bullet":STATVALUES.NEUTRAL,
	"melee":STATVALUES.NEUTRAL,
	"weight":STATVALUES.AVERAGE,
	"radioactive":STATVALUES.FALSE,
	"knockback":STATVALUES.FALSE,
	"cost":0
}
var dictionary : Dictionary
var json

class_name Armors

func _ready():
	pass
	
func find(text):
	for n in _data:
		if _data[n].get('name') == text:
			return _data[n]
	
	return default
	
# gets a random item from the list that is afforable given the provided budget
func get_random(budget):
	var available = []
	for n in _data:
		if _data[n].cost <= budget:
			available.append(_data[n])
	
	return available[randi() % len(available)].name
	
func get_data():
	json = to_json(_data)
	dictionary = JSON.parse(json).result
	return dictionary

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
