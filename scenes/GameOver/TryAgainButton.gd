extends Button

export(String, FILE, "*.tsc, *.tscn") var target_scene

func _ready() -> void:
	var err = self.connect("pressed", self, "_on_pressed")
	if err: print(err)

func _on_pressed():
	# reset settings
	Global.money = Global.initial_money
	Global.store = Global.initial_store
	
	# play the sound
	get_parent().find_node('Click').play()
	
	# switch scene
	Global.transition(get_tree().current_scene, target_scene, 1, Color.black)
