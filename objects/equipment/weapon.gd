extends Resource


# Declare member variables here. Examples:
# var a = 2
var stats


func _init(newStats):
	stats = newStats
	
	
	#print(weaponStats)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func attack(grid_pos,facing):
	var hitsquares = []
	var hitpercent = randf()
	if hitpercent > stats['hitPercent']:
		return ['miss',[],stats['damage'],0]
	match(facing):
		Vector2.UP:
			for ndx in range(1,stats['range']):
				for spreadIndex in range(-stats['spread']*stats['range'],stats['spread']*stats['range']):
					hitsquares.append(Vector2(grid_pos.x+spreadIndex,grid_pos.y+ndx))
		Vector2.DOWN:
			for ndx in range(1,stats['range']):
				for spreadIndex in range(-stats['spread']*stats['range'],stats['spread']*stats['range']):
					hitsquares.append(Vector2(grid_pos.x+spreadIndex,grid_pos.y-ndx))
		Vector2.LEFT:
			for ndx in range(1,stats['range']):
				for spreadIndex in range(-stats['spread']*stats['range'],stats['spread']*stats['range']):
					hitsquares.append(Vector2(grid_pos.x-ndx,grid_pos.y+spreadIndex))
		Vector2.RIGHT:
			for ndx in range(1,stats['range']):
				for spreadIndex in range(-stats['spread']*stats['range'],stats['spread']*stats['range']):
					hitsquares.append(Vector2(grid_pos.x+ndx,grid_pos.y+spreadIndex))
	return ['hit',hitsquares,stats['damage'],stats['damageAmount']]

class_name Weapon

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass