extends KinematicBody2D

export var move_speed := 100
export var gravity := 2000
export var jump_speed := 500


var velocity := Vector2.ZERO



func _process(delta: float) -> void:
		change_animation()

func change_animation():
	if velocity.x > 0:
		$AnimatedSprite.flip_h = false
	elif velocity.x < 0:
		$AnimatedSprite.flip_h = true
	if velocity.y < 0:
		$AnimatedSprite.play("jump")
	else:
		if velocity.x != 0:
			$AnimatedSprite.play("walk")
		else:
			$AnimatedSprite.play("idle")

