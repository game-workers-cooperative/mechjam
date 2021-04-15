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
