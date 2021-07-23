extends KinematicBody2D

#export var move_speed := 100
export var gravity := 2000
export var jump_speed := 500
export var max_speed := 200
export var acceleration := 100
export var deacceleration := 50
export var push_back := Vector2 (500,-250)

var velocity := Vector2.ZERO
var rDirection = true
signal enemy_pushed
push = true



	

func _physics_process(delta: float) -> void:


	if Input.is_action_pressed("move_right") and velocity.x < max_speed and is_on_floor():
		velocity.x += acceleration
	if is_on_floor() and velocity.x > 0:
		velocity.x -= deacceleration
				
	if Input.is_action_pressed("move_left") and velocity.x > -max_speed and is_on_floor():		
		velocity.x -= acceleration
	if is_on_floor() and velocity.x < 0:
		velocity.x += deacceleration

#	print(velocity.x)

	velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = -jump_speed # negative Y is up in Godot
			
	velocity = move_and_slide(velocity, Vector2.UP)



func _process(delta: float) -> void:
		change_animation()

func change_animation() -> void:
		
	
	if velocity.y < 0:
		$AnimatedSprite.play("jump")
	else:
		if velocity.x != 0:
			$AnimatedSprite.play("walk")
		else:
			$AnimatedSprite.play("idle")
			
	if Input.is_action_just_pressed("move_right") and rDirection == false :
		transform *= Transform2D.FLIP_X
		rDirection = true

	if Input.is_action_just_pressed("move_left") and rDirection == true :
		transform *= Transform2D.FLIP_X
		rDirection = false



func _on_WeaponArea_area_entered(area) -> void:
	
	if push == true and rDirection == true and area.is_in_group("Weapon"):
		velocity.x -= push_back.x/2
		velocity.y += push_back.y/2
			
	elif push == true and rDirection == false and area.is_in_group("Weapon"):
		velocity.x += push_back.x/2
		velocity.y += push_back.y/2
		
func _on_WeaponArea_body_entered(body):

	if push == true and rDirection == true and body.name("Player2"):
		emit_signal(push_back)
		
	elif push == true and rDirection == false and body.name("Player2"):
		emit_signal(-push_back)
		
#	print(velocity)
#
	
	#func _on_WeaponArea_body_entered(body) -> void:
#
#	if body.name == "Player2":
#		get_tree().paused = true
#		print("Player 1 wins bitches")
	
#	if Input.is_action_just_pressed("change_stance") and push == true:
#		push = false
#
#	if Input.is_action_just_pressed("change_stance") and push == false:
#		push = true		
#FUNKTIONIERT NOCH NICHT


