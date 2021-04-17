extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var ArmorScrollContainer  = $ArmorScrollContainer

func _ready():
	pass
	
func _toggled(button_pressed):
	ArmorScrollContainer.visible = !ArmorScrollContainer.visible


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
