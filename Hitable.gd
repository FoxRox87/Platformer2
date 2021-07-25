extends KinematicBody2D

export var maxHp:= 1
export var hp := 100
export var bloodColor:=Color(1,0,0)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hp = maxHp
	$BloodFountain.set_color(bloodColor)
	pass # Replace with function body.

func hit(damage: int):
	if hp >= damage:
		hp -= damage
	else:
		hp = 0
	$BloodFountain.set_emitting(true)		
	print(hp)
	if hp == 0:
		die()
func die():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
