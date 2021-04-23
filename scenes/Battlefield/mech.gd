extends Node

class_name Mech

signal move_finished

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
var grid_pos = Vector2(5, 5)
enum {ALIVE,DEAD}
var functionality = ALIVE

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
	tween.interpolate_property(object, "translation", object.get_translation(), object.get_translation() + translation, 0.25, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_all_completed")
	emit_signal("move_finished")
	
# applies environment damage if needed
func check_environment_damage():
	var type = map.get_tile_type(object.translation)
	match type:
		'spike':
			if leg['traction']!=legValues.HIGH:
				take_damage(1)

# tries to move
func try_move(translation):
	if(!can_move(translation)):
		translation = Vector3(0,0,0)
		
	move(translation)
	check_environment_damage()

func jump():
	if leg['jump'] == legValues.TRUE:
		JUMPSTATE = true
		
func attack(weaponSlot):
	# AnimationPlayer.play("weapon.get_animation")
	if weaponSlot == 'primary':
		primaryWeapon.attack(grid_pos,face_dir)
	elif weaponSlot =='secondary':
		secondaryWeapon.attack(grid_pos,face_dir)

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
	HP-=damageAmount
	if HP <0:
		functionality = DEAD
		
func knockback(origin):
	var knockbackAmount = 1
	var currentPosition = grid_pos
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
	get_parent().try_move(currentPosition)
	
func turnLeft():
	match(face_dir):
		Vector2.LEFT:
			face_dir = Vector2.DOWN
		Vector2.RIGHT:
			face_dir = Vector2.UP
		Vector2.UP:
			face_dir = Vector2.LEFT
		Vector2.DOWN:
			face_dir = Vector2.RIGHT
			
func turnRight():
	match(face_dir):
		Vector2.LEFT:
			face_dir = Vector2.UP
		Vector2.RIGHT:
			face_dir = Vector2.DOWN
		Vector2.UP:
			face_dir = Vector2.RIGHT
		Vector2.DOWN:
			face_dir = Vector2.LEFT

# sets up this object
func _init(objectInScene, currentMap, maxHealth, equippedArmor, equippedCockpit, equippedLeg, equippedPrimaryWeapon, equippedSecondaryWeapon):
	object = objectInScene
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
	if(armor.stats != false):
		match(armor.stats['weight']):
			effects.LIGHT:
				MAX_HP-=2
				HP-=2
				SPEED+=1
			effects.HEAVY:
				MAX_HP+=2
				HP-=2
				SPEED-=1

	# make sure legs are equipped before applying effects	
	if(leg.stats != false):
		match(leg.stats['mobility']):
			legValues.LOW:
				SPEED-=1
			legValues.HIGH:
				SPEED+=1
	
	# make sure a cockpit exists before applying effects
	if cockpit:
		var specs = cockpit.get_specs()
		for spec in specs:
			self[spec] += specs[spec]

# gets the current speed of the mech
func get_speed():
	return SPEED
