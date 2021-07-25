extends Node2D

export var damage := 10

func _process(delta):
	rotate(delta)

func _on_OuchTimer_timeout():
	for body in $OuchArea.get_overlapping_bodies():
		if body.is_in_group("hitable"):
			body.hit(damage)
