extends Resource


# Declare member variables here. Examples:
# var a = 2
var stats

func _init(newStats):
	stats = newStats
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func aim(grid_pos,facing):
	var hitsquares = []
	print(facing)
	print(Vector2.UP)
	print(Vector2.DOWN)
	print(Vector2.LEFT)
	print(Vector2.RIGHT)
	match(Vector2(facing.x,facing.y)):
		Vector2(0,-1):
			for ndx in range(1,stats['range']):
				for spreadIndex in range(-stats['spread']*stats['range'],stats['spread']*stats['range']):
					hitsquares.append(Vector2(grid_pos.x+spreadIndex,grid_pos.y+ndx))
		Vector2(0,1):
			for ndx in range(1,stats['range']):
				for spreadIndex in range(-stats['spread']*stats['range'],stats['spread']*stats['range']):
					hitsquares.append(Vector2(grid_pos.x+spreadIndex,grid_pos.y-ndx))
		Vector2(-1,0):
			for ndx in range(1,stats['range']):
				for spreadIndex in range(-stats['spread']*stats['range'],stats['spread']*stats['range']):
					hitsquares.append(Vector2(grid_pos.x-ndx,grid_pos.y+spreadIndex))
		Vector2(1,0):
			for ndx in range(1,stats['range']):
				for spreadIndex in range(-stats['spread']*stats['range'],stats['spread']*stats['range']):
					hitsquares.append(Vector2(grid_pos.x+ndx,grid_pos.y+spreadIndex))
	return hitsquares
	
func attack(grid_pos,facing):
	var hitsquares = []
	
	var hitpercent = randf()
	if hitpercent > stats['hitPercent']:
		return ['miss',[],stats['damage'],0]
	hitsquares = aim(grid_pos,facing)
	# make sure to not hit the mech that used the weapon
	var index = hitsquares.find(Vector2(grid_pos.x, grid_pos.z))
	if index > -1:
		hitsquares.remove(index)

	return ['hit',hitsquares,stats['damage'],stats['damageAmount']]

class_name Weapon

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
