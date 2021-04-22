extends KinematicBody2D

signal move_finished

export(Resource) var cockpit
export(Resource) var weapon_scene
export(String) var element
export(Vector2) var tile_size = Vector2(64, 32)

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
var effects = Armors.STATVALUES

var velocity = Vector2.ZERO
var face_dir = Vector2.DOWN
var grid_pos = Vector2(5, 5)
enum {ALIVE,DEAD}
var functionality = ALIVE

onready var tween = $Tween
onready var global = get_node("/root/Global")
	
func _ready() -> void:
	
	armor = Armor.new(Armors.new().find(global.store['equipped']['armor']))
	cockpit = Cockpit.new(Cockpits.new().find(global.store['equipped']['cockpit']))
	leg = Leg.new(Legs.new().find(global.store['equipped']['leg']))
	primaryWeapon = Weapon.new(Weapons.new().find(global.store['equipped']['weapon'][0]))
	secondaryWeapon = Weapon.new(Weapons.new().find(global.store['equipped']['weapon'][1]))
	match(armor.stats['weight']):
		effects.LIGHT:
			MAX_HP-=2
			HP-=2
			SPEED+=1
		effects.HEAVY:
			MAX_HP+=2
			HP-=2
			SPEED-=1
	match(leg.stats['mobility']):
		legValues.LOW:
			SPEED-=1
		legValues.HIGH:
			SPEED+=1
	#weapon = Weapon.new(curWeapon)
	
	global_position = cart_to_iso(grid_pos) * tile_size
	
	if cockpit:
		var specs = cockpit.get_specs()
		for spec in specs:
			self[spec] += specs[spec]

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

func move(dir: Vector2) -> void:
	grid_pos += dir
	
	tween.interpolate_property(self, "global_position", global_position, cart_to_iso(grid_pos) * tile_size, 0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
	yield(tween, "tween_all_completed")
	emit_signal("move_finished")
	

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

func hit_spike():
	if leg['traction']!=legValues.HIGH:
		take_damage(1)
	
func cart_to_iso(pos: Vector2):
	return Vector2(pos.x - pos.y, (pos.y + pos.x)/2.0)
