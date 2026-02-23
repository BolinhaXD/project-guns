extends BaseEnemy
class_name ShootingEnemy

@onready var bullet_scene = preload("res://Assets/Scenes/Enemies/blood_projectile.tscn")
@onready var anim_sprite_2d: AnimatedSprite2D = $"Agent Animation/AnimatedSprite2D"
@onready var marker2d: Marker2D = $Marker2D


var shooting: bool = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if !is_on_floor():
		velocity.y += gravity * delta
		velocity.x = 0
	
	move(delta)
	move_and_slide()


func move(delta: float) -> void:
	if !is_dead:
		if !is_chase:
			velocity += direction * speed * speed_multiplier * delta
		if is_chase and !taking_damage:
			var direction_to_player = position.direction_to(player.position) * speed * speed_multiplier
			velocity.x = direction_to_player.x
			direction.x = abs(velocity.x) / velocity.x
			if direction.x > 0:
				marker2d.position.x = abs(marker2d.position.x)
			else:
				marker2d.position.x = -11.5
			if shooting:
				velocity.x = 0
	else:
		velocity.x = 0


func _on_timer_timeout() -> void:
	$Timer.wait_time = choose([1.5,2.0,2.5])
	if !is_chase:
		direction = choose([Vector2.RIGHT, Vector2.LEFT])
		if direction.x > 0:
			marker2d.position.x = abs(marker2d.position.x)
		else:
			marker2d.position.x = -11.5
		velocity.x = 0


func _on_sight_range_area_entered(area: Area2D) -> void:
	if area.get_parent() is PlayerController:
		player = area.get_parent()
		is_chase = true
		is_roaming = false


func _on_sight_range_area_exited(area: Area2D) -> void:
	if area.get_parent() is PlayerController:
		player = null
		is_chase = false
		is_roaming = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is PlayerController:
		shooting = true
		$Cooldown.start()


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is PlayerController:
		shooting = false
		$Cooldown.stop()


func _on_cooldown_timeout() -> void:
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.global_position = marker2d.global_position
	if direction.x == -1: 
		bullet_instance.rotation_degrees = 180
	elif direction.x == 1:
		bullet_instance.rotation_degrees = 0
	get_tree().root.add_child(bullet_instance)
	$Cooldown.start()


func _on_animated_sprite_2d_animation_finished() -> void:
	if anim_sprite_2d.animation == "dead":
		queue_free()
