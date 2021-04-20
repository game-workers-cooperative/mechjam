extends Node2D

const CommandBlock = preload("res://objects/ui/CommandBlock.tscn")

onready var mecha = $Mecha

onready var command_editor = $HUD/CommandEditor
onready var command_palette = $HUD/CommandPalette

var commands = []

func _ready() -> void:
	for button in command_palette.get_children():
		button.connect("command_selected", self, "_on_command_selected")

func execute_commands():
	for command in commands:
		print(command)
		mecha.call(command.method, command.parameters)
		yield(mecha, "move_finished")
	
	commands = []

func _on_command_selected(button):
	
	var block = CommandBlock.instance()
	block.connect("block_selected", self, "_on_block_selected")
	block.set_text(button.get_text())
	block.index = commands.size()
	commands.append(button.command)
	command_editor.add_child(block)

func _on_block_selected(block):
	commands.remove(block.index)
	block.queue_free()
	check_block_index()
	
	print(commands)

func check_block_index():
	var i = 0
	for block in command_editor.get_children():
		block.index = i
		i += 1

func _on_StartBtn_pressed() -> void:
	execute_commands()
