extends Node2D

export var damage := 10
var off := false


func _process(delta):
	if not off:
		rotate(delta*10)

func _on_OuchTimer_timeout():
	for body in $OuchArea.get_overlapping_bodies():
		if body.is_in_group("hitable"):
			body.hit(damage)
			off = true
			$OuchTimer.stop()
