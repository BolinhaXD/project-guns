extends ItemBaseHand

@onready var collision: CollisionShape2D = $Area2D/CollisionShape2D

func item_attack():
	collision.disabled = false
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_rotation", 4, 0.5)
	tween.set_ease(Tween.EASE_OUT)
	await tween.finished
	collision.disabled = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)
