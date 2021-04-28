extends Button

signal command_selected(button)

export(Dictionary) var command = {
	"method": "",
	"parameters": 0
}

func _ready() -> void:
	self.connect("pressed", self, "_on_pressed")

func _on_pressed():
	get_parent().get_parent().get_parent().find_node('Click').play()
	emit_signal("command_selected", self)
