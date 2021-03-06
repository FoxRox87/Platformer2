extends KinematicBody2D

export var gravity := 2000
export var jump_speed := 500
export var max_speed := 200
export var acceleration := 100
export var deacceleration := 50
export var push_back := Vector2 (500,-250)


var velocity := Vector2.ZERO
var lDirection = true
var push = true

func _ready():
		transform *= Transform2D.FLIP_X

func _physics_process(delta: float) -> void:

	if Input.is_action_pressed("move_right2") and velocity.x < max_speed and is_on_floor():
		velocity.x += acceleration
	if is_on_floor() and velocity.x > 0:
		velocity.x -= deacceleration
		
	if Input.is_action_pressed("move_left2") and velocity.x > -max_speed and is_on_floor():		
		velocity.x -= acceleration
	if is_on_floor() and velocity.x < 0:
		velocity.x += deacceleration

	velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump2"):
		if is_on_floor():
			velocity.y = -jump_speed # negative Y is up in Godot
			
	velocity = move_and_slide(velocity, Vector2.UP)

func _process(delta: float) -> void:
		change_animation()

func bounce_left():
	if push == true:
		velocity.x -= push_back.x
		velocity.y += push_back.y
func bounce_right():
	if push == true:
		velocity.x += push_back.x
		velocity.y += push_back.y

#	elif push == true and lDirection == false:
#		velocity.x -= push_back.x
#		velocity.y += push_back.y
	
func change_animation():

	if velocity.y < 0:
		$AnimatedSprite.play("jump")
	else:
		if velocity.x != 0:
			$AnimatedSprite.play("walk")
		else:
			$AnimatedSprite.play("idle")
			
			
	if Input.is_action_just_pressed("move_left2") and lDirection == false:
		transform *= Transform2D.FLIP_X
		lDirection = true
		
	if Input.is_action_just_pressed("move_right2") and lDirection == true:
		transform *= Transform2D.FLIP_X
		lDirection = false

func _on_WeaponArea_body_entered(body):

	if push == true and body.name == "Player" and lDirection == false:
		body.bounce_right()
	if push == true and body.name == "Player" and lDirection == true:
		body.bounce_left()

#func _on_WeaponArea_area_entered(area) -> void:
#
#	if push == true and lDirection == true and area.is_in_group("Weapon"):
#		velocity.x += push_back.x
#		velocity.y += push_back.y
#
#	elif push == true and lDirection == false and area.is_in_group("Weapon"):
#		velocity.x -= push_back.x
#		velocity.y += push_back.y

#func _on_WeaponArea_body_entered(body):
#
#	if body.name == "Player":
#		get_tree().paused = true
#		print("Player 2 wins bitches")
#func _on_WeaponArea_body_entered(body) -> void:
#
#	if lDirection == true and Input.is_action_pressed("push"):
#			velocity += push_back
#	elif lDirection == false and Input.is_action_pressed("push"):
#			velocity -= push_back
#
#		var impulse = get_transform().translated(-get_transform().origin) * push_back
#		velocity = -impulse
##		velocity += push_back
			
