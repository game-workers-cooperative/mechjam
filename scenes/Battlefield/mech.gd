extends Node

class_name Mech

signal move_finished

var object
var map
var health
var position

var tween

# checks to see if it's possible to move
func can_move(translation):
	# check if the environment stops the move
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
			
	# check if there's another mech in the way
	var mechs = map.get_mechs()
	for mech in mechs:
		var sameLocation = mech.get_position() == get_position() + translation
		if mech != self and sameLocation:
			return false
	
	return true

func get_position():
	return object.translation

# applies the provided translation
func move(translation):
	if tween:
		tween.interpolate_property(object, "translation", object.get_translation(), object.get_translation() + translation, 0.25, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		tween.start()
		yield(tween, "tween_all_completed")
		emit_signal("move_finished")
	else:
		object.translate(translation)
	
# applies environment damage if needed
func check_environment_damage():
	var type = map.get_tile_type(object.translation)
	match type:
		'spike': health -= 1

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
	tween = object.get_node_or_null("Tween")
