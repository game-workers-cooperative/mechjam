extends Control
enum STATVALUES {HIGH,AVERAGE,LOW,TRUE,FALSE}
var stats =["weight","armor","shield"]
var _data :={
	"0": {
		"name":"Standard",
		"weight":STATVALUES.AVERAGE,
		"armor":STATVALUES.AVERAGE,
		"shield":STATVALUES.FALSE,
		"cost":0
	},
	"1": {
		"name":"Lightweight",
		"weight":STATVALUES.LOW,
		"armor":STATVALUES.LOW,
		"shield":STATVALUES.FALSE,
		"cost":150
	},
	"2": {
		"name":"Shielded",
		"weight":STATVALUES.AVERAGE,
		"armor":STATVALUES.LOW,
		"shield":STATVALUES.TRUE,
		"cost":175
	},	
	"3": {
		"name":"Heavy",
		"weight":STATVALUES.HIGH,
		"armor":STATVALUES.HIGH,
		"shield":STATVALUES.FALSE,
		"cost":225
	},
}
var default = {
	"name":"Default",
	"weight":STATVALUES.AVERAGE,
	"armor":STATVALUES.AVERAGE,
	"shield":STATVALUES.FALSE,
	"cost":0
}
var dictionary : Dictionary
var json

class_name Cockpits

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
