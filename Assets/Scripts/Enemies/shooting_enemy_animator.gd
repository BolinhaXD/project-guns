extends EnemyAnimator
class_name ShootingEnemyAnimator

func _physics_process(_delta: float) -> void:
	if enemy_controller.direction.x == -1: 
		animated_sprite.flip_h = true
	elif enemy_controller.direction.x == 1:
		animated_sprite.flip_h = false
	
	if enemy_controller.is_dead:
		animated_sprite.play("dead")
	elif enemy_controller.shooting:
		animated_sprite.play("walk")
	elif abs(enemy_controller.velocity.x) > 0.0:
		animated_sprite.play("walk")
	else: 
		animated_sprite.play("idle")
