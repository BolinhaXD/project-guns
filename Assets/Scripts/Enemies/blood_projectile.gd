extends ProjectileBase

func _ready() -> void:
	SPEED = 100
	damage = 5
	pass # Replace with function body.


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Ground"):
		queue_free()
	elif body is PlayerController:
		body.take_damage(damage)
		queue_free()
