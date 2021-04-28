extends Button

onready var global = get_node("/root/Global")

export(String, FILE, "*.tsc, *.tscn") var target_scene

func _ready() -> void:
	var err = self.connect("pressed", self, "_on_pressed")
	if err: print(err)

func _on_pressed():
	# give player and enemy money to play with
	Global.rounds += 1
	Global.money += 100 * Global.rounds
	Global.enemy_money += 100 * Global.rounds
	
	# play the sound
	get_parent().find_node('Click').play()
	
	# change the scene
	Global.transition(get_tree().current_scene, target_scene, 1, Color.black)
