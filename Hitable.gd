extends KinematicBody2D

export var maxHp:= 100
export var hp := 100
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hp = maxHp
	pass # Replace with function body.

func hit(damage: int):
	if hp > 0:
		hp -= damage
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
