extends Resource
class_name Cockpit

export(int) var HP
export(int) var speed
export(int) var armor

func get_specs() -> Dictionary:
	return {
		"HP": HP,
		"SPEED": speed,
		"ARMOR": armor
	}

var stats

func _init(newStats):
	stats = newStats
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
