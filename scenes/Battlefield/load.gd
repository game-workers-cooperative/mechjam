extends Node

# map of id to file
var map = {
	0: {
		'label': 'StandIn_BasicGroundTile',
		'wall': false
	},
	1: {
		'label': 'StandIn_BarrelObstacle',
		'wall': false
	},
	2: {
		'label': 'StandIn_GridGroundTile',
		'wall': false
	},
	3: {
		'label': 'StandIn_SpikeGroundTile',
		'wall': false
	},
	4: {
		'label': 'StandIn_WindowlessCornerTile',
		'wall': true
	},
	5: {
		'label': 'StandIn_WindowlessWallTile',
		'wall': true
	},
}

# tiles of the battlefield by row
var level = [
	[
		4,5,5,5,4
	],
	[
		5,3,0,3,5
	],
	[
		5,0,1,0,5
	],
	[
		5,3,0,3,5
	],
	[
		4,5,5,5,4
	]
]

# adds a tile to the scene
func add_tile(tileIndex, rowIndex, mapped, position):
	# duplicate a hidden asset node
	var node = self.get_node("WorldEnvironment/" + mapped.label).duplicate()
	
	# position the new node
	var x = Vector3(1, 0, 0)
	var y = Vector3(0, 1, 0)
	var z = Vector3(0, 0, 1)
	var origin = Vector3(tileIndex, 0, rowIndex)
	node.transform = Transform(x, y, z, origin)
	node.visible = true
	
	# if this is a wall, we need to rotate it some
	if mapped.wall:		
		# figure out how to rotate it
		var rotateMap = {
			'top' : PI/2,
			'bottom' : PI/2,
			'left' : PI/2,
			'right' : PI/2
		}
		
		var axis = Vector3(0, 1, 0)
		node.rotate(axis, rotateMap[position])
		
	# add the node
	self.add_child(node)

# Called when the node enters the scene tree for the first time.
func _ready():
	for rowIndex in len(level):
		for tileIndex in len(level[rowIndex]):
			# figure out which tile to use
			var mapped = map[level[rowIndex][tileIndex]]
			
			var position = 'top'
			
			# add the tile
			add_tile(tileIndex, rowIndex, mapped, position)
			


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
