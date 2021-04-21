extends Node

class_name Mech

var object
var map
var health

# checks to see if it's possible to move
func can_move(translation):
	var type = map.get_tile_type(object.translation + translation)
	match type:
		'bottom_wall':
			return false
		'top_wall':
			return false
		'left_wall':
			return false
		'right_wall':
			return false
		'top_left_corner':
			return false
		'top_right_corner':
			return false
		'bottom_left_corner':
			return false
		'bottom_right_corner':
			return false
			
	return true

# applies the provided translation
func move(translation):
	object.translate(translation)
	
# applies environment damage if needed
func check_environment_damage():
	var type = map.get_tile_type(object.translation)
	match type:
		'spike': health -= 1
	print(health)

# tries to move
func try_move(translation):
	if(can_move(translation)):
		move(translation)
		check_environment_damage()
		
# sets up this object
func _init(objectInScene, currentMap, maxHealth):
	object = objectInScene
	map = currentMap
	health = maxHealth

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass