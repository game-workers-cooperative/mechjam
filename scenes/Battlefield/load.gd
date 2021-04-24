extends Node

const CommandBlock = preload("res://objects/ui/CommandBlock.tscn")

var map
var player
var enemy

var commands = []

onready var command_editor = $HUD/CommandEditor
onready var command_palette = $HUD/CommandPalette
onready var startBtn = $HUD/StartBtn
onready var global = get_node("/root/Global")

# Called when the node enters the scene tree for the first time.
func _ready():
	# get a map object
	map = Map.new()	
	
	# position the player
	var playerObject = self.get_node("WorldEnvironment/Player")
	var armor = Armor.new(Armors.new().find(global.store['equipped']['armor']))
	var cockpit = Cockpit.new(Cockpits.new().find(global.store['equipped']['cockpit']))
	var leg = Leg.new(Legs.new().find(global.store['equipped']['leg']))
	var primaryWeapon = Weapon.new(Weapons.new().find(global.store['equipped']['weapon'][0]))
	var secondaryWeapon = Weapon.new(Weapons.new().find(global.store['equipped']['weapon'][1]))
	player = Mech.new(playerObject, map, 10, armor, cockpit, leg, primaryWeapon, secondaryWeapon)
	player.try_move(map.get_midpoint())
	
	# position the enemy
	var enemyObject = self.get_node("WorldEnvironment/Enemy")
	enemy = Mech.new(enemyObject, map, 10, armor, cockpit, leg, primaryWeapon, secondaryWeapon)
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
	# disable all selected commands
	for block in command_editor.get_children():
		block.set_disabled(true)
		
	# execute the commands
#	for commandIndex in len(commands):
#		# run the command
#		var command = commands[commandIndex]
#		player.call(command.method, command.parameters)
#		yield(player, "move_finished")
#
#		# remove the command from the queue
#		var child = command_editor.get_child(commandIndex)
#		command_editor.remove_child(child)
	print(commands)
	while commands.size() > 0:
		var command = commands[0]
		player.call(command.method, command.parameters)
		yield(player, "move_finished")
		
		commands.remove(0)
		var child = command_editor.get_child(0)
		command_editor.remove_child(child)
	
	command_palette.set_visible(true)
	startBtn.set_visible(true)
	# @todo i don't think this should be necessary but it is
#	while len(command_editor.get_children()) != 0:
#		command_editor.remove_child(command_editor.get_children()[0])
#	commands = []

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
	# limit by the mech's speed
	if(player.get_speed() >= len(command_editor.get_children())):
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

func testMoves(position,facing,depth,moves):
	
	var possibleMoves = ['forward','backward','left','right','attack','attack2','skip']
	var moveScores = []
	var newPos = position
	var newAngle = facing
	var testAngle = facing
	for testMove in possibleMoves:
		var score = 0
		match(testMove):
			'forward':
				newPos = position+facing
				testAngle = newPos.angle_to(player.grid_pos)
			'backward':
				newPos = position-facing
				testAngle = newPos.angle_to(player.grid_pos)
			'left':
				newAngle = facing.rotated(-deg2rad(90))
			'right':
				newAngle = facing.rotated(deg2rad(90))
			'attack1':
				var weaponHitArea = enemy.primaryWeapon.aim(position,facing)
				if weaponHitArea.search(player.grid_pos):
					score = 0
				else:
					score +=10
			'attack2':
				var weaponHitArea = enemy.secondaryWeapon.aim(position,facing)
				if weaponHitArea.find(player.grid_pos):
					score = 0
				else:
					score +=10
			'skip':
				pass
		moves[testMove] = score
		score += testAngle
		score = position.distance_to(newPos)
		score += abs(testAngle + position.angle_to(player.grid_pos))
		if depth>=0:
			testMoves(newPos, newAngle, depth-1, moves)
		else:
			return moves

func calculate_enemy_action():
	
	#for testMove in enemy.SPEED
	var possibleMoves = testMoves(enemy.grid_pos,enemy.face_dir,enemy.SPEED,{})
	print(possibleMoves)
	
			

# Executes the commands(Starts Battle Phase)
func _on_StartBtn_pressed() -> void:
	calculate_enemy_action()
	execute_commands()
	command_palette.set_visible(false)
	startBtn.set_visible(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for mech in map.get_mechs():
		if mech.HP <= 0:
			# trigger win/lose screen if necessary
			if mech.object == $WorldEnvironment/Player:
				get_tree().change_scene('res://scenes/GameOver/GameOver.tscn')
			else:
				get_tree().change_scene('res://scenes/Victory/Victory.tscn')
