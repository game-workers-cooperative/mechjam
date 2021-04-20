extends Node

var money = 200

var store = {
	'bought': {
		'armors':[
			false,
			false,
			false,
			false,
			false,
			false,
		],
		'cockpits':[
			false,
			false,
			false,
			false
		],
		'legs':[
			false,
			false,
			false,
			false
		],
		'weapons':[
			false,
			false,
			false,
			false,
			false,
		],
	}
}

var save_store_path = "user://save"

func save_store():
	var file = File.new()
	file.open(save_store_path,file.WRITE_READ)
	file.store_var(store)
	file.close()
	
func load_store():
	var file = File.new()
	if not file.file_exists(save_store_path):
		return false
	file.open(save_store_path, file.READ)
	store = file.get_var()
	file.close()
	return true

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	load_store()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass