extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var buttons = [
	{
		"name": "armor",
		"iconx":0,
		"icony":256
	},
	{
		"name": "weapon",
		"iconx": 180,
		"icony": 116
	}
]

# Called when the node enters the scene tree for the first time.
func _ready():
	var test = Button.new().theme
	for btn in buttons:
		var newButton = MenuButton.new()
		newButton.set_size(Vector2(100,80))
		newButton.text = btn["name"]
		newButton.theme.set_color("grey")
		
		newButton.theme = load("res://resources/mechjam_theme.tres")
		var icon = Sprite.new()
		icon.texture = load("res://resources/icons-sbed.svg")
		icon.region_enabled = true
		var region = Rect2(btn["iconx"],btn["icony"],32,32)
		icon.region_rect = region
		icon.position += Vector2(10,10)
		icon.scale = Vector2(0.5,0.5)
		
		newButton.add_child(icon)
		add_child(newButton)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
