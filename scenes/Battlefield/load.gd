extends Node

# map of id to file
var map = {
	'floor': {
		'asset': 'StandIn_BasicGroundTile',
		'wall': false,
		'rotate': 0,
		'damage_touch': 0,
		'damage_active': 0
	},
	'barrel': {
		'asset': 'StandIn_BarrelObstacle',
		'wall': false,
		'rotate': 0,
		'damage_touch': 0,
		'damage_active': 1
	},
	'grid': {
		'asset': 'StandIn_GridGroundTile',
		'wall': false,
		'rotate': 0,
		'damage_touch': 0,
		'damage_active': 0
	},
	'spike': {
		'asset': 'StandIn_SpikeGroundTile',
		'wall': false,
		'rotate': 0,
		'damage_touch': 1,
		'damage_active': 0
	},
	'bottom_left_corner': {
		'asset': 'StandIn_WindowlessCornerTile',
		'wall': true,
		'rotate': PI/2,
		'damage_touch': 0,
		'damage_active': 0
	},
	'bottom_right_corner': {
		'asset': 'StandIn_WindowlessCornerTile',
		'wall': true,
		'rotate': PI,
		'damage_touch': 0,
		'damage_active': 0
	},
	'top_left_corner': {
		'asset': 'StandIn_WindowlessCornerTile',
		'wall': true,
		'rotate': 0,
		'damage_touch': 0,
		'damage_active': 0
	},
	'top_right_corner': {
		'asset': 'StandIn_WindowlessCornerTile',
		'wall': true,
		'rotate': -PI/2,
		'damage_touch': 0,
		'damage_active': 0
	},
	'top_wall': {
		'asset': 'StandIn_WindowlessWallTile',
		'wall': true,
		'rotate': PI/2,
		'damage_touch': 0,
		'damage_active': 0
	},
	'left_wall': {
		'asset': 'StandIn_WindowlessWallTile',
		'wall': true,
		'rotate': PI,
		'damage_touch': 0,
		'damage_active': 0
	},
	'right_wall': {
		'asset': 'StandIn_WindowlessWallTile',
		'wall': true,
		'rotate': 0,
		'damage_touch': 0,
		'damage_active': 0
	},
	'bottom_wall': {
		'asset': 'StandIn_WindowlessWallTile',
		'wall': true,
		'rotate': -PI/2,
		'damage_touch': 0,
		'damage_active': 0
	},
}

# tiles of the battlefield by row
var level = [
	[
		'top_left_corner','top_wall','top_wall','top_wall','top_right_corner'
	],
	[
		'left_wall','spike','floor','spike','right_wall'
	],
	[
		'left_wall','floor','barrel','floor','right_wall'
	],
	[
		'left_wall','spike','floor','spike','right_wall'
	],
	[
		'bottom_left_corner','bottom_wall','bottom_wall','bottom_wall','bottom_right_corner'
	]
]

# adds a tile to the scene
func add_tile(tileIndex, rowIndex, mapped):
	# duplicate a hidden asset node
	var node = self.get_node("WorldEnvironment/" + mapped.asset).duplicate()
	
	# position the new node
	var x = Vector3(1, 0, 0)
	var y = Vector3(0, 1, 0)
	var z = Vector3(0, 0, 1)
	var origin = Vector3(tileIndex, 0, rowIndex)
	node.transform = Transform(x, y, z, origin)
	node.visible = true
	
	var axis = Vector3(0, 1, 0)
	node.rotate(axis, mapped.rotate)
	
	# add the node
	self.add_child(node)

# Called when the node enters the scene tree for the first time.
func _ready():
	for rowIndex in len(level):
		for tileIndex in len(level[rowIndex]):
			# figure out which tile to use
			var label = level[rowIndex][tileIndex]
			var mapped = map[label]
						
			# add the tile	
			add_tile(tileIndex, rowIndex, mapped)
			
			# add tile under this one if needed
			if label == 'barrel':
				add_tile(tileIndex, rowIndex, map['floor'])


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
