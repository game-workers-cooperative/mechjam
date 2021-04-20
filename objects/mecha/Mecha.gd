extends KinematicBody2D

signal move_finished

export(Resource) var cockpit
export(Resource) var weapon_scene
export(String) var element
export(Vector2) var tile_size = Vector2(64, 32)

var SPEED = 250
var MAX_HP = 10
var HP = 10
var ARMOR = 0

var weapon

var velocity = Vector2.ZERO
var face_dir = Vector2.DOWN
var grid_pos = Vector2(5, 5)

onready var tween = $Tween

func _ready() -> void:
	global_position = cart_to_iso(grid_pos) * tile_size
	
	if cockpit:
		var specs = cockpit.get_specs()
		for spec in specs:
			self[spec] += specs[spec]

func move(dir: Vector2) -> void:
	grid_pos += dir
	
	tween.interpolate_property(self, "global_position", global_position, cart_to_iso(grid_pos) * tile_size, 0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
	yield(tween, "tween_all_completed")
	emit_signal("move_finished")

func attack():
	# AnimationPlayer.play("weapon.get_animation")
	weapon.attack(face_dir)

func cart_to_iso(pos: Vector2):
	return Vector2(pos.x - pos.y, (pos.y + pos.x)/2.0)
