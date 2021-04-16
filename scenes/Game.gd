extends Node2D

var commands = [
	{"method": "move", "parameters": Vector2.RIGHT},
	{"method": "move", "parameters": Vector2.UP},
	{"method": "move", "parameters": Vector2.RIGHT}
]

onready var mecha = $Mecha

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	execute_commands()

func execute_commands():
	for command in commands:
		mecha.call(command.method, command.parameters)
		yield(mecha, "move_finished")
