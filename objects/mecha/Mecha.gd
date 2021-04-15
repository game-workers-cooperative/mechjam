extends KinematicBody2D

export(Resource) var cockpit
export(Resource) var weapon
export(String) var element

var SPEED = 250
var MAX_HP = 10
var HP = 10
var ARMOR = 0

var velocity = Vector2.ZERO

func _ready() -> void:
	if cockpit:
		var specs = cockpit.get_specs()
		for spec in specs:
			self[spec] += specs[spec]

func _physics_process(_delta: float) -> void:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	velocity = input_vector * SPEED
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if Input.is_action_just_pressed("lmb"):
		print("Shoot")
