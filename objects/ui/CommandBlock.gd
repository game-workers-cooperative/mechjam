extends Button

signal block_selected(block)

var index

func _ready() -> void:
	self.connect("pressed", self, "_on_block_pressed")

func _on_block_pressed():
	emit_signal("block_selected", self)
