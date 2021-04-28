extends Node

var initial_money = 50
var money = initial_money
var enemy_money = initial_money
var rounds = 1

var initial_store = {
	'bought': {
		'armors':[
			true,
			true,
			false,
			false,
			false,
			false,
		],
		'cockpits':[
			true,
			false,
			false,
			false
		],
		'legs':[
			true,
			false,
			false,
			false
		],
		'weapons':[
			false,
			false,
			false,
			true,
			false,
		],
	},
	'equipped':
		{
			'armor':'none',
			'cockpit':'none',
			'leg':'none',
			'weapon':['none','none'],
		}
}
var store = initial_store

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

func _ready():
	load_store()

func transition(from, to, duration, color):
	var rootControl = CanvasLayer.new()
	var colorRect = ColorRect.new()
	
	var tween = Tween.new()
	
	colorRect.set_frame_color(Color(0, 0, 0, 0))
	
	get_tree().get_root().add_child(rootControl)
	rootControl.add_child(colorRect)
	rootControl.add_child(tween)
	colorRect._set_size(Vector2(1024, 600))
	
	tween.interpolate_property(colorRect, "color", Color(0, 0, 0, 0), color, duration/2.0, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
	yield(tween, "tween_all_completed")
	var new_scene = load(to).instance()
	get_tree().get_root().add_child(new_scene)
	from.queue_free()
	
	tween.interpolate_property(colorRect, "color", colorRect.get_frame_color(), Color(0, 0, 0, 0), duration/2.0, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
	yield(tween, "tween_all_completed")
	
	get_tree().set_current_scene(new_scene)
	rootControl.queue_free()
