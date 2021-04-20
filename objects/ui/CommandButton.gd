extends Button

signal command_selected(button)

export(Dictionary) var command = {
	"method": "",
	"parameters": 0
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.connect("pressed", self, "_on_pressed")

func _on_pressed():
	emit_signal("command_selected", self)
