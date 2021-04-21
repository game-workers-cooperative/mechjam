extends Node

var map
var player
var enemy

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
	
	# build the map
	map.build_map(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
