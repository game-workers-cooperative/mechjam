extends Node

class_name Mech

signal move_finished
signal weapon_attack(attackArray)

export(Resource) var cockpit

var object
var map
var position
var tween
var SPEED = 5
var MAX_HP = 10
var HP = 10
var ARMOR = 0
var SHIELD = 0
var SHIELDCOOLDOWN = 0
var JUMPSTATE = false
var armor
var leg
var primaryWeapon
var secondaryWeapon
var effects = Armors.STATVALUES
var damagetypes = Weapons.STATVALUES
var cockpitValues = Cockpits.STATVALUES
var legValues = Legs.STATVALUES
var weapon
var velocity = Vector2.ZERO
var face_dir = Vector2.DOWN
enum {ALIVE,DEAD}
var functionality = ALIVE



# checks to see if it's possible to move
func can_move(translation):
	# check if the environment stops the move
	var type = map.get_tile_type(object.translation + translation)
	var info = map.get_type_info(type)
	if info.wall:
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
	# play the step sound
	var player = object.get_parent().get_parent().find_node('Step1')
	player.play()
	
	# move the player
	tween.interpolate_property(object, "translation", object.get_translation(), object.get_translation() + translation, 0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
	# play the other step sound
	player = object.get_parent().get_parent().find_node('Step2')
	player.play()
	
	yield(tween, "tween_all_completed")
	
	# tell the command manager we're done
	emit_signal("move_finished")
	
# applies environment damage if needed
func check_environment_damage():
	var type = map.get_tile_type(object.translation)
	
	match type:
		'spike':
			if !JUMPSTATE and leg.stats['traction'] != legValues.HIGH:
				take_damage(1)
	
	# see if adjacent tiles are saws
	var adjacentSaw = 'left_saw' == map.get_tile_type(Vector3(object.translation.x - 1, 0, object.translation.z))
	adjacentSaw = adjacentSaw or 'right_saw' == map.get_tile_type(Vector3(object.translation.x + 1, 0, object.translation.z))
	adjacentSaw = adjacentSaw or 'top_saw' == map.get_tile_type(Vector3(object.translation.x, 0, object.translation.z - 1))
	adjacentSaw = adjacentSaw or 'bottom_saw' == map.get_tile_type(Vector3(object.translation.x, 0, object.translation.z + 1))
	if adjacentSaw:
		take_damage(1)

# tries to move
func try_move(translation):
	var translation_rotated = translation.rotated(Vector3(0, 1, 0), object.get_rotation().y)
	
	if(!can_move(translation_rotated)):
		translation_rotated = Vector3(0,0,0)
		
	move(translation_rotated)

func jump():
	if leg['jump'] == legValues.TRUE:
		JUMPSTATE = true
		
func attack(weaponSlot):
	# figure out which weapon to use
	var weapon = primaryWeapon
	if weaponSlot == 'secondary':
		weapon = secondaryWeapon
	
	# play sound effect based on name
	var playerName
	var player
	match weapon.stats['name']:
		'Gun Type Weapon':
			playerName = 'Gunshot'
		'Energy Type weapon':
			playerName = 'Laser'
		'Melee Weapon':
			playerName = 'Punch'
		'FlameThrower':
			playerName = 'Flamethrower'
	if typeof(playerName) == TYPE_STRING:
		player = object.get_parent().get_parent().find_node(playerName)
		player.play()
	
	# AnimationPlayer.play("weapon.get_animation")
	
	# attack
	var attackArray = weapon.attack(get_position(),face_dir)
	attackArray.append(get_position())
	emit_signal("weapon_attack",attackArray)
	
	# find which animation to run
	var shot = null
	match weapon.stats['name']:
		'Gun Type Weapon':
			shot = object.get_parent().find_node('Shot')
		'Energy Type weapon':
			shot = object.get_parent().find_node('Laser')
			
	# animate attack
	if shot:
		shot.translation = object.translation
		shot.visible = true
		var offset = Vector3(0, 0, 0)
		var length = 5
		match(face_dir):
			Vector2.LEFT:
				length = map.get_midpoint().x * 2
				offset = Vector3(-length, 0, 0)
			Vector2.RIGHT:
				length = map.get_midpoint().x * 2
				offset = Vector3(length, 0, 0)
			Vector2.UP:
				length = map.get_midpoint().z * 2
				offset = Vector3(0, 0, -length)
			Vector2.DOWN:
				length = map.get_midpoint().z * 2
				offset = Vector3(0, 0, length)
		tween.interpolate_property(
			shot,
			"translation",
			shot.translation,
			shot.translation + offset,
			0.25,
			Tween.TRANS_SINE,
			Tween.EASE_IN_OUT
		)
		tween.start()
		yield(tween, "tween_all_completed")
		shot.visible = false
	
	# make sure the sound is done
	if typeof(playerName) == TYPE_STRING:
		yield(player, 'finished')
		
	# let the command manager know we're done
	emit_signal("move_finished")

func raise_shield():
	if cockpit['shield'] == cockpitValues.TRUE and SHIELDCOOLDOWN <= 0:
		SHIELD+=2
		return true
	else:
		return false

func hit(damageType,origin):
	var returnState
	if JUMPSTATE:
		returnState = false
	elif SHIELD > 0:
		SHIELD -=1
		if SHIELD ==0:
			SHIELDCOOLDOWN = 1
		returnState = false
	else:
		take_damage(armor.hit(damageType))
		returnState = true
		
	if damageType == damagetypes.MELEE:
		knockback(origin)
		
	return returnState
  
func take_damage(damageAmount):
	HP -= damageAmount
	if HP <= 0:
		functionality = DEAD
	
func knockback(origin):
	var knockbackAmount = 1
	var currentPosition = get_position()
	if leg['name']== 'Hover':
		knockbackAmount += 1
	if origin.x == currentPosition.x:
		if origin.y>currentPosition.y:
			currentPosition.y-=knockbackAmount
		else:
			currentPosition.y+=knockbackAmount
	elif origin.y == currentPosition.y:
		if origin.x>currentPosition.x:
			currentPosition.x-=knockbackAmount
		else:
			currentPosition.x+=knockbackAmount
	try_move(currentPosition)
	
func turn_left():
	# turn the mech
	tween.interpolate_property(object, "rotation", object.rotation, object.get_rotation() + Vector3(0, PI/2, 0), 0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_all_completed")
	
	# update the direction it is facing
	match(face_dir):
		Vector2.LEFT:
			face_dir = Vector2.DOWN
		Vector2.RIGHT:
			face_dir = Vector2.UP
		Vector2.UP:
			face_dir = Vector2.LEFT
		Vector2.DOWN:
			face_dir = Vector2.RIGHT
	
	# let the command manager know we're done
	emit_signal("move_finished")
			
func turn_right():
	tween.interpolate_property(object, "rotation", object.rotation, object.get_rotation() - Vector3(0, PI/2, 0), 0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
	yield(tween, "tween_all_completed")
	
	match(face_dir):
		Vector2.LEFT:
			face_dir = Vector2.UP
		Vector2.RIGHT:
			face_dir = Vector2.DOWN
		Vector2.UP:
			face_dir = Vector2.RIGHT
		Vector2.DOWN:
			face_dir = Vector2.LEFT
			
	# let the command manager know we're done
	emit_signal("move_finished")

# sets up this object
func _init(objectInScene, facingDirection, currentMap, maxHealth, equippedArmor, equippedCockpit, equippedLeg, equippedPrimaryWeapon, equippedSecondaryWeapon):
	object = objectInScene
	face_dir = facingDirection
	map = currentMap
	MAX_HP = maxHealth
	HP = maxHealth
	tween = object.get_node("Tween")
	
	# initialize equipment
	armor = equippedArmor
	cockpit = equippedCockpit
	leg = equippedLeg
	primaryWeapon = equippedPrimaryWeapon
	secondaryWeapon = equippedSecondaryWeapon

	# make sure an armor is equipped before applying effects	
	match(armor.stats['weight']):
		effects.LIGHT:
			MAX_HP -= 2
			HP -= 2
			SPEED += 1
		effects.HEAVY:
			MAX_HP += 2
			HP += 2
			SPEED -= 1

	# make sure legs are equipped before applying effects	
	match(leg.stats['mobility']):
		legValues.LOW:
			SPEED -= 1
		legValues.HIGH:
			SPEED += 1
	
	# make sure a cockpit exists before applying effects
	var specs = cockpit.get_specs()
	for spec in specs:
		self[spec] += specs[spec]

# gets the current speed of the mech
func get_speed():
	return SPEED
