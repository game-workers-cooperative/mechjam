extends Node

class_name Map

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
		'asset': 'StandIn_BasicCornerTile',
		'wall': true,
		'rotate': PI/2,
		'damage_touch': 0,
		'damage_active': 0
	},
	'bottom_right_corner': {
		'asset': 'StandIn_BasicCornerTile',
		'wall': true,
		'rotate': PI,
		'damage_touch': 0,
		'damage_active': 0
	},
	'top_left_corner': {
		'asset': 'StandIn_BasicCornerTile',
		'wall': true,
		'rotate': 0,
		'damage_touch': 0,
		'damage_active': 0
	},
	'top_right_corner': {
		'asset': 'StandIn_BasicCornerTile',
		'wall': true,
		'rotate': -PI/2,
		'damage_touch': 0,
		'damage_active': 0
	},
	'top_wall': {
		'asset': 'StandIn_BasicWallTile',
		'wall': true,
		'rotate': -PI/2,
		'damage_touch': 0,
		'damage_active': 0
	},
	'left_wall': {
		'asset': 'StandIn_BasicWallTile',
		'wall': true,
		'rotate': PI*2,
		'damage_touch': 0,
		'damage_active': 0
	},
	'right_wall': {
		'asset': 'StandIn_BasicWallTile',
		'wall': true,
		'rotate': PI,
		'damage_touch': 0,
		'damage_active': 0
	},
	'bottom_wall': {
		'asset': 'StandIn_BasicWallTile',
		'wall': true,
		'rotate': PI/2,
		'damage_touch': 0,
		'damage_active': 0
	},
	'top_window_wall': {
		'asset': 'StandIn_WindowlessWallTile',
		'wall': true,
		'rotate': PI/2,
		'damage_touch': 0,
		'damage_active': 0
	},
	'left_window_wall': {
		'asset': 'StandIn_WindowlessWallTile',
		'wall': true,
		'rotate': PI,
		'damage_touch': 0,
		'damage_active': 0
	},
	'right_window_wall': {
		'asset': 'StandIn_WindowlessWallTile',
		'wall': true,
		'rotate': PI*2,
		'damage_touch': 0,
		'damage_active': 0
	},
	'bottom_window_wall': {
		'asset': 'StandIn_WindowlessWallTile',
		'wall': true,
		'rotate': -PI/2,
		'damage_touch': 0,
		'damage_active': 0
	},
	'left_saw': {
		'asset': 'StandIn_SawWallTile',
		'wall': true,
		'rotate': 0,
		'damage_touch': 1,
		'damage_active': 0
	},
	'top_saw': {
		'asset': 'StandIn_SawWallTile',
		'wall': true,
		'rotate': -PI/2,
		'damage_touch': 1,
		'damage_active': 0
	},
	'bottom_saw': {
		'asset': 'StandIn_SawWallTile',
		'wall': true,
		'rotate': PI/2,
		'damage_touch': 1,
		'damage_active': 0
	},
	'right_saw': {
		'asset': 'StandIn_SawWallTile',
		'wall': true,
		'rotate': PI,
		'damage_touch': 1,
		'damage_active': 0
	},
}

# tiles of the battlefield by row
var level = [
	[
		'top_left_corner','top_window_wall','top_window_wall','top_window_wall','top_window_wall','top_window_wall','top_window_wall','top_window_wall','top_saw','top_right_corner'
	],
	[
		'left_window_wall','floor','spike','floor','floor','floor','floor','spike','floor','right_window_wall'
	],
	[
		'left_window_wall','floor','floor','floor','floor','floor','floor','floor','floor','right_window_wall'
	],
	[
		'left_window_wall','floor','spike','floor','floor','floor','floor','spike','floor','right_window_wall'
	],
	[
		'left_window_wall','floor','spike','floor','floor','floor','floor','spike','floor','right_window_wall'
	],
	[
		'left_window_wall','floor','floor','floor','floor','floor','floor','floor','floor','right_window_wall'
	],
	[
		'left_saw','floor','spike','floor','floor','floor','floor','spike','floor','right_window_wall'
	],
	[
		'left_window_wall','floor','spike','floor','floor','floor','floor','spike','floor','right_saw'
	],
	[
		'left_window_wall','floor','floor','floor','floor','floor','floor','floor','floor','right_window_wall'
	],
	[
		'left_window_wall','floor','spike','floor','floor','floor','floor','spike','floor','right_window_wall'
	],
	[
		'bottom_left_corner','bottom_window_wall','bottom_window_wall','bottom_saw','bottom_window_wall','bottom_window_wall','bottom_window_wall','bottom_window_wall','bottom_window_wall','bottom_right_corner'
	]
]

# list of all mechs on the map
var mechs = []

# adds a tile to the scene
func add_tile(baseNode, tileIndex, rowIndex, mapped):
	# duplicate a hidden asset node
	var node = baseNode.get_node("WorldEnvironment/" + mapped.asset).duplicate()
	
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
	baseNode.add_child(node)

# gets the tile type of the provided location
func get_tile_type(location):
	return level[location.z][location.x]

# builds a map from the given level info
func build_map(baseNode):
	for rowIndex in len(level):
		for tileIndex in len(level[rowIndex]):
			# figure out which tile to use
			var label = level[rowIndex][tileIndex]
			var mapped = map[label]
						
			# add the tile	
			add_tile(baseNode, tileIndex, rowIndex, mapped)
			
			# add tile under this one if needed
			if label == 'barrel':
				add_tile(baseNode, tileIndex, rowIndex, map['floor'])

# returns the midpoint of the map
func get_midpoint():
	return Vector3(
		floor(len(level)/2),
		0,
		floor(len(level[0])/2)
	)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# add to the list of mechs
func add_mech(mech):
	mechs.append(mech)

# get the mech list
func get_mechs():
	return mechs

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
