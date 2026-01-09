extends CharacterBody2D
class_name BaseEnemy

@export var speed: float = 6.0
@export var speed_multiplier = 10.0

@export var health_points: float = 100.0

var is_roaming: bool = true
var is_chase: bool = false

var is_dead: bool = false
var damage: float = 20.0
var taking_damage: bool = false
var dealing_damage: bool = false

var direction: Vector2
const gravity = 900

var player: PlayerController

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if !is_on_floor():
		velocity.y += gravity * delta
		velocity.x = 0
	
	move(delta)
	move_and_slide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func move(delta: float) -> void:
	if !is_dead:
		if !is_chase:
			velocity += direction * speed * speed_multiplier * delta
		if is_chase and !taking_damage:
			var direction_to_player = position.direction_to(player.position) * speed * speed_multiplier
			velocity.x = direction_to_player.x
			direction.x = abs(velocity.x) / velocity.x
	else:
		velocity.x = 0


func take_damage(_damage):
	if health_points > _damage:
		health_points -= _damage
	else:
		health_points = 0
		dead()
	print("Enemy Health: ", health_points)


func dead():
	velocity.x = 0
	is_dead = true


func _on_timer_timeout() -> void:
	$Timer.wait_time = choose([1.5,2.0,2.5])
	if !is_chase:
		direction = choose([Vector2.RIGHT, Vector2.LEFT])
		velocity.x = 0


func choose(array: Array):
	array.shuffle()
	return array.front()


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
		dealing_damage = true
		$Cooldown.start()


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is PlayerController:
		dealing_damage = false
		$Cooldown.stop()


func _on_cooldown_timeout() -> void:
	player.take_damage(damage)
	$Cooldown.start()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "dead":
		queue_free()
