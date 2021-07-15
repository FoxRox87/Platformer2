extends KinematicBody2D

export var move_speed := 100
export var gravity := 2000
export var jump_speed := 500


var velocity := Vector2.ZERO

func _physics_process(delta: float) -> void:

	velocity.x = 0

	if Input.is_action_pressed("move_right"):
		velocity.x += move_speed
	if Input.is_action_pressed("move_left"):
		velocity.x -= move_speed

	velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = -jump_speed # negative Y is up in Godot
			
	velocity = move_and_slide(velocity, Vector2.UP)

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
