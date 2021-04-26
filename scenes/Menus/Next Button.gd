extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	var err = self.connect("pressed", self, "_on_pressed")
	if err: print(err)

func _on_pressed():
	var parent = get_parent()
	var screen1 = parent.find_node('Screen1')
	var screen2 = parent.find_node('Screen2')
	var screen3 = parent.find_node('Screen3')
	var text1 = parent.find_node('Dialogue1')
	var text2 = parent.find_node('Dialogue2')
	var text3 = parent.find_node('Dialogue3')
	var title = parent.find_node('Title')
	var nextButton = parent.find_node('Next Button')
	var skipIntroButton = parent.find_node('Skip Intro Button')
	var buttonHolder = parent.find_node('ButtonHolder')
	var startButton = parent.find_node('StartGame')
	var creditsButton = parent.find_node('CreditsButton')
	var visible1 = screen1.visible
	var visible2 = screen2.visible
	var visible3 = screen3.visible
	if visible1:
		screen1.visible = false
		screen2.visible = true
		text1.visible = false
		text2.visible = true
	elif visible2:
		screen2.visible = false
		screen3.visible = true
		text2.visible = false
		text3.visible = true
	elif visible3:		
		text3.visible = false
		title.visible = true
		nextButton.visible = false
		skipIntroButton.visible = false
#		buttonHolder.visible = true
		startButton.visible = true
		creditsButton.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
