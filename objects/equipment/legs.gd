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
		"cost":10
	},
	"1": {
		"name":"Bipedal",
		"mobility":STATVALUES.AVERAGE,
		"agility":STATVALUES.AVERAGE,
		"jump":STATVALUES.TRUE,
		"traction":STATVALUES.AVERAGE,
		"cost":10
	},
	"2": {
		"name":"Treads",
		"mobility":STATVALUES.LOW,
		"agility":STATVALUES.LOW,
		"jump":STATVALUES.FALSE,
		"traction":STATVALUES.HIGH,
		"cost":10
	},	
	"3": {
		"name":"Hover",
		"mobility":STATVALUES.HIGH,
		"agility":STATVALUES.LOW,
		"jump":STATVALUES.FALSE,
		"traction":STATVALUES.AVERAGE,
		"cost":10
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
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
