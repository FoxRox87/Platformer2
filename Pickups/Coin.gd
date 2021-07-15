extends Area2D


func _on_Coin_body_entered(body: Node) -> void:
	$AnimatedSprite.play("pickup")
	$AudioStreamPlayer2D.play()

func _on_AudioStreamPlayer2D_finished() -> void:
	queue_free()
