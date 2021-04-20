extends Control
enum {IMMUNE,STRONG,NEUTRAL,WEAK,LIGHT,AVERAGE,HEAVY}

var _data :={
	"1": {
		"name":"Steel",
		"blade":STRONG,
		"fire":NEUTRAL,
		"energy":WEAK,
		"bullet":STRONG,
		"melee":NEUTRAL,
		"weight":HEAVY,
		"radioactive":false,
		"knockback":false
	},
	"2": {
		"name":"Carbon Nanotech",
		"blade":WEAK,
		"fire":STRONG,
		"energy":STRONG,
		"bullet":NEUTRAL,
		"melee":NEUTRAL,
		"weight":LIGHT,
		"radioactive":false,
		"knockback":false
	},
	"3": {
		"name":"Ceramic",
		"blade":WEAK,
		"fire":IMMUNE,
		"energy":STRONG,
		"bullet":WEAK,
		"melee":WEAK,
		"weight":AVERAGE,
		"radioactive":false,
		"knockback":false
	},	
	"4": {
		"name":"Alien Hardwood",
		"blade":NEUTRAL,
		"fire":WEAK,
		"energy":NEUTRAL,
		"bullet":NEUTRAL,
		"melee":STRONG,
		"weight":AVERAGE,
		"radioactive":false,
		"knockback":false
	},
	"5": {
		"name":"Radioactive Waste",
		"blade":WEAK,
		"fire":WEAK,
		"energy":WEAK,
		"bullet":WEAK,
		"melee":WEAK,
		"weight":WEAK,
		"radioactive":true,
		"knockback":false
	},
	"6": {
		"name":"Rubber",
		"blade":NEUTRAL,
		"fire":NEUTRAL,
		"energy":STRONG,
		"bullet":WEAK,
		"melee":STRONG,
		"weight":AVERAGE,
		"radioactive":false,
		"knockback":true
	},
}
var dictionary : Dictionary
var json

class_name Armor

func _ready():
	pass
	
func get_data():
	json = to_json(_data)
	dictionary = JSON.parse(json).result
	return dictionary
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
