extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.get_node("DeathTimer"):
		body.take_damage(1)
