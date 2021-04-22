extends Node

const CommandBlock = preload("res://objects/ui/CommandBlock.tscn")

var map
var player
var enemy

var commands = []

onready var command_editor = $HUD/CommandEditor
onready var command_palette = $HUD/CommandPalette

# Called when the node enters the scene tree for the first time.
func _ready():
	# get a map object
	map = Map.new()	
	
	# position the player
	var playerObject = self.get_node("WorldEnvironment/Mech")
	player = Mech.new(playerObject, map, 10)
	player.try_move(map.get_midpoint())
	
	# position the enemy
	var enemyObject = self.get_node("WorldEnvironment/Enemy")
	enemy = Mech.new(enemyObject, map, 10)
	var enemyPosition = map.get_midpoint()
	enemyPosition.x += 2
	enemyPosition.z += 2
	enemy.try_move(enemyPosition)
	
	# add mechs to the map
	map.add_mech(player)
	map.add_mech(enemy)
	map.build_map(self)
	
	# Connect each button's pressed signal to this node
	for button in command_palette.get_children():
		button.connect("command_selected", self, "_on_command_selected")

func execute_commands():
	for command in commands:
		print(command)
		player.call(command.method, command.parameters)
		yield(player, "move_finished")
	
	clear_children(command_editor)
	commands = []

# Utils

# Changes the index property of the blocks to be correct if any block is removed to avoid discontinued indexes
func check_block_index():
	var i = 0
	for block in command_editor.get_children():
		block.index = i
		i += 1

# Remove all the children from the parent node
func clear_children(parent):
	for child in parent.get_children():
		parent.remove_child(child)

# Signal Connections

# Adds the Command to the command editor and command list
func _on_command_selected(button):
	var block = CommandBlock.instance()
	block.connect("block_selected", self, "_on_block_selected")
	block.set_text(button.get_text())
	block.index = commands.size()
	commands.append(button.command)
	command_editor.add_child(block)


# Removes the command from the editor and list
func _on_block_selected(block):
	commands.remove(block.index)
	block.queue_free()
	check_block_index()
	
#	print(commands)

# Executes the commands(Starts Battle Phase)
func _on_StartBtn_pressed() -> void:
	execute_commands()
