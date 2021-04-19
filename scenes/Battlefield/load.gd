extends Node

# map of id to file
var map = {
	0: {
		'label': 'StandIn_BasicGroundTile',
		'top': false
	},
	1: {
		'label': 'StandIn_BarrelObstacle',
		'top': true
	},
	2: {
		'label': 'StandIn_GridGroundTile',
		'top': false
	},
	3: {
		'label': 'StandIn_SpikeGroundTile',
		'top': false
	},
	4: {
		'label': 'StandIn_WindowlessCornerTile',
		'top': false
	},
	5: {
		'label': 'StandIn_WindowlessWallTile',
		'top': false
	},
}

# tiles of the battlefield by row
var level = [
	[
		0,0,2,0,0
	],
	[
		0,3,0,3,0
	],
	[
		2,0,1,0,2
	],
	[
		0,3,0,3,0
	],
	[
		0,0,2,0,0
	]
]

# adds a tile to the scene
func add_tile(tileIndex, rowIndex, mapped):
	var node = self.get_node("WorldEnvironment/" + mapped.label).duplicate()
	var x = Vector3(1, 0, 0)
	var y = Vector3(0, 1, 0)
	var z = Vector3(0, 0, 1)
	var origin = Vector3(tileIndex, 0, rowIndex)
	node.transform = Transform(x, y, z, origin)
	node.visible = true
	self.add_child(node)

# Called when the node enters the scene tree for the first time.
func _ready():
	for rowIndex in len(level):
		for tileIndex in len(level[rowIndex]):
			# figure out which tile to use
			var mapped = map[level[rowIndex][tileIndex]]
			
			# if this is a top tile, add a basic tile under it
			if mapped.top:
				add_tile(tileIndex, rowIndex, map[0])
			
			# add the tile
			add_tile(tileIndex, rowIndex, mapped)
			


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
