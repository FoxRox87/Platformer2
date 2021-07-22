extends KinematicBody2D

export var gravity := 2000
export var jump_speed := 500
export var max_speed := 200
export var acceleration := 100
export var deacceleration := 50
export var push_back := Vector2 (500,150)


var velocity := Vector2.ZERO
var lDirection = true

func _ready():
		transform *= Transform2D.FLIP_X

func _physics_process(delta: float) -> void:

	if Input.is_action_pressed("move_right2") and velocity.x < max_speed:
		velocity.x += acceleration
	if is_on_floor() and velocity.x > 0:
		velocity.x -= deacceleration
		
	if Input.is_action_pressed("move_left2") and velocity.x > -max_speed:		
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
	
	if body.name == "Player":
		get_tree().paused = true
		print("Player 2 wins bitches")
func _on_WeaponArea_area_entered(area) -> void:

	if area.is_in_group("Weapon") and lDirection == true:
			velocity += push_back
	elif area.is_in_group("Weapon") and lDirection == false:
			velocity -= push_back
#		var impulse = get_transform().translated(-get_transform().origin) * push_back
#		velocity = -impulse
##		velocity += push_back
			
