extends Area2D

signal checkpoint_reached

func _on_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("checkpoint_reached")
		queue_free()  # one-time use
