extends Button

export(String, FILE, "*.tsc, *.tscn") var target_scene

func _ready() -> void:
	self.disabled
	var err = self.connect("pressed", self, "_on_pressed")
	if err: print(err)

func _on_pressed():
	# play the click noise
	var player = self.get_parent().find_node('Click')
	if player:
		player.play()

	Global.transition(get_tree().current_scene, target_scene, 1, Color.black)
