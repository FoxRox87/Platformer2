extends "res://Objects/Player.gd"

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
