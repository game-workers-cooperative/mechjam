extends Tabs

onready var priceArmor = [
	str2var($"RichTextLabel/controller/Steel/Label2".text),
	str2var($"RichTextLabel/controller/Carbon Nanotech/Label3".text),
	str2var($"RichTextLabel/controller/Ceramic/Label4".text),
	str2var($"RichTextLabel/controller/Alien Hardwood/Label5".text),
	str2var($"RichTextLabel/controller/Radioactive Waste/Label6".text),
	str2var($"RichTextLabel/controller/Rubber/Label7".text)
	]






# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$RichTextLabel/controller.position.x = -$HScrollBar.value

func _buy(price,id):
	print(Global.store['bought']['armor'][id])
	if Global.money >= price:
		Global.money -= price
		Global.store['bought']['armor'][id] = true
	else:
		var rem = price - Global.money
		$modal/Label.text = "You need "+str(rem)+" additional funds to purchase this item."
		$modal.show()
		
func _on_Button0_pressed():
	_buy(priceArmor[0],0)
func _on_Button1_pressed():
	_buy(priceArmor[1],1)
func _on_Button2_pressed():
	_buy(priceArmor[2],2)
func _on_Button3_pressed():
	_buy(priceArmor[3],3)
func _on_Button4_pressed():
	_buy(priceArmor[4],4)
func _on_Button5_pressed():
	_buy(priceArmor[5],5)


func _on_modal_Button_pressed():
	$modal.hide()
