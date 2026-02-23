extends BaseEnemy
class_name MeleeEnemy

@onready var anim_sprite_2d: AnimatedSprite2D = $"Agent Animation/AnimatedSprite2D"

func _on_animated_sprite_2d_animation_finished() -> void:
	if anim_sprite_2d.animation == "dead":
		queue_free()
