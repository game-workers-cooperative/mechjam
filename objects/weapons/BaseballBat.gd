extends Area2D

onready var collider = $CollisionShape2D
onready var tween = $Tween

func _ready() -> void:
	collider.set_disabled(true)

func attack() -> void:
	collider.set_disabled(false)
	
	tween.interpolate_property(self, "rotation", -90, 90, 0.25, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
	yield(tween, "tween_all_completed")
	
	tween.interpolate_property(self, "rotation", 90, -90, 0.25, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
	yield(tween, "tween_all_completed")
	
	collider.set_disabled(true)
