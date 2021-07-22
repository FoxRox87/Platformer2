extends Node2D

func _ready():	
	if Input.is_action_pressed("restart"):
		get_tree().reload_current_scene()
