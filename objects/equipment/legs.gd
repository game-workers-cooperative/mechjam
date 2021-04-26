extends Control
enum STATVALUES {HIGH,AVERAGE,LOW,TRUE,FALSE}
var stats =["mobility","agility","jump","traction"]
var _data :={
	"0": {
		"name":"Wheels",
		"mobility":STATVALUES.HIGH,
		"agility":STATVALUES.HIGH,
		"jump":STATVALUES.FALSE,
		"traction":STATVALUES.AVERAGE,
		"cost":0
	},
	"1": {
		"name":"Bipedal",
		"mobility":STATVALUES.AVERAGE,
		"agility":STATVALUES.AVERAGE,
		"jump":STATVALUES.TRUE,
		"traction":STATVALUES.AVERAGE,
		"cost":150
	},
	"2": {
		"name":"Treads",
		"mobility":STATVALUES.LOW,
		"agility":STATVALUES.LOW,
		"jump":STATVALUES.FALSE,
		"traction":STATVALUES.HIGH,
		"cost":75
	},	
	"3": {
		"name":"Hover",
		"mobility":STATVALUES.HIGH,
		"agility":STATVALUES.LOW,
		"jump":STATVALUES.FALSE,
		"traction":STATVALUES.AVERAGE,
		"cost":300
	},
}
var default = {
	"name":"Default",
	"mobility":STATVALUES.AVERAGE,
	"agility":STATVALUES.AVERAGE,
	"jump":STATVALUES.FALSE,
	"traction":STATVALUES.AVERAGE,
	"cost":0
}
var dictionary : Dictionary
var json

class_name Legs

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
