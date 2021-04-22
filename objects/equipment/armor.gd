extends Resource
var effects = Armors.STATVALUES

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var stats

func _init(newStats):
	stats = newStats
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func hit(damageType):
	match(stats[damageType]):
		effects.IMMUNE:
			return 0
		effects.STRONG:
			return 1
		effects.NEUTRAL:
			return 2
		effects.WEAK:
			return 3	
	

class_name Armor

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
