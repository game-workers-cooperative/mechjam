extends Button

onready var global = get_node("/root/Global")

export(String, FILE, "*.tsc, *.tscn") var target_scene

func _ready() -> void:
	var err = self.connect("pressed", self, "_on_pressed")
	if err: print(err)

func _on_pressed():
	Global.money += 100
	Global.enemy_money += 100
	var err = get_tree().change_scene(target_scene)
	if err: print(err)
