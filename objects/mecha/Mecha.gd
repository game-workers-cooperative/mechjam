extends KinematicBody2D

signal move_finished

export(Resource) var cockpit
export(PackedScene) var weapon_scene
export(String) var element
export(Vector2) var tile_size = Vector2(64, 32)

var SPEED = 250
var MAX_HP = 10
var HP = 10
var ARMOR = 0

var weapon

var velocity = Vector2.ZERO
var grid_pos = Vector2.ZERO

var commands = [
	{"method": "move", "parameters": Vector2.RIGHT},
	{"method": "move", "parameters": Vector2.UP},
	{"method": "move", "parameters": Vector2.RIGHT}
]

onready var tween = $Tween

func _ready() -> void:
	global_position = cart_to_iso(grid_pos)
	
	if cockpit:
		var specs = cockpit.get_specs()
		for spec in specs:
			self[spec] += specs[spec]

func _input(event: InputEvent) -> void:
	if not event.is_pressed(): return
	
	var input_dir = Vector2.ZERO
	
	if event.is_action_pressed("ui_right"):
		input_dir.x += 1
	elif event.is_action_pressed("ui_left"):
		input_dir.x -= 1
	
	if event.is_action_pressed("ui_down"):
		input_dir.y += 1
	elif event.is_action_pressed("ui_up"):
		input_dir.y -= 1
	
	if event.is_action_pressed("ui_accept"): execute()
	
	move(input_dir)

func execute() -> void:
	for command in commands:
		call(command.method, command.parameters)

func move(dir: Vector2) -> void:
	grid_pos += dir
	
	tween.interpolate_property(self, "global_position", global_position, cart_to_iso(grid_pos) * tile_size, 0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
	yield(tween, "tween_all_completed")
	emit_signal("move_finished")

func cart_to_iso(pos: Vector2):
	return Vector2(pos.x - pos.y, (pos.y + pos.x)/2.0)
