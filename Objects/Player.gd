extends "../Hitable.gd"

export var gravity := 2000
export var jump_speed := 500
export var max_speed := 200
export var acceleration := 500

export var resistance := 200

export var deacceleration := 50
export var aiControlled := false

export var push_back := Vector2 (50,-50)


export var playerId := 0

var velocity := Vector2.ZERO
var lDirection = true

export var playerColor := Color(0,0,1)

func _ready():
		transform *= Transform2D.FLIP_X
		$AnimatedSprite.set_modulate(playerColor)
		if aiControlled:
			$AITimer.start()

func _physics_process(delta: float) -> void:
	if hp == 0:
		return
	
	if Input.is_action_pressed("move_right%d" % playerId) and velocity.x < max_speed:
		velocity.x += acceleration *delta
	if is_on_floor() and velocity.x > 0:
		velocity.x -= resistance *delta
		
	if Input.is_action_pressed("move_left%d" % playerId) and velocity.x > -max_speed:		
		velocity.x -= acceleration *delta
	if is_on_floor() and velocity.x < 0:
		velocity.x += resistance *delta

	if aiControlled and is_on_floor():
		if lDirection and velocity.x < max_speed:
			velocity.x += acceleration
		if not lDirection and velocity.x > -max_speed:
			velocity.x -=acceleration
		var r = rand_range(0, 50)
		if r < 1.0 and is_on_floor():
			velocity.y = -jump_speed # negative Y is up in Godot

			
	

	velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump%d" % playerId):
		if is_on_floor():
			velocity.y = -jump_speed # negative Y is up in Godot
		elif Input.is_action_just_pressed("jump%d" % playerId) and lDirection == true:
			velocity.x = -200
			velocity.y = -200
		elif Input.is_action_just_pressed("jump%d" % playerId) and lDirection == false:
			velocity.x = 200
			velocity.y = -200
	velocity = move_and_slide(velocity, Vector2.UP)

func _process(delta: float) -> void:
		change_animation()

func bounce(impuls):
	velocity = impuls
	
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
			
			
	if Input.is_action_just_pressed("move_left%d" % playerId) and lDirection == false:
		transform *= Transform2D.FLIP_X
		lDirection = true
		
	if Input.is_action_just_pressed("move_right%d" % playerId) and lDirection == true:
		transform *= Transform2D.FLIP_X
		lDirection = false

func _on_WeaponArea_body_entered(body):
	if body == self:
		return
		
	if body.is_in_group("player"):
		print (lDirection)
		if lDirection:
			body.bounce(Vector2(-push_back.x, push_back.y))
		else:
			body.bounce(push_back)

func die():
	$AnimatedSprite.hide()


func _on_AITimer_timeout():
	var r = rand_range(0, 2)
	if r < 1.0:
		lDirection =  !lDirection # Replace with function body.
