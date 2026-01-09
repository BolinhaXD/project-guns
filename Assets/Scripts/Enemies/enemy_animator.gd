extends Node2D
class_name EnemyAnimator

@export var enemy_controller : CharacterBody2D
@export var animated_sprite: AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(_delta: float) -> void:
	if enemy_controller.direction.x == -1: 
		animated_sprite.flip_h = true
	elif enemy_controller.direction.x == 1:
		animated_sprite.flip_h = false
	
	if enemy_controller.is_dead:
		animated_sprite.play("dead")
	elif enemy_controller.dealing_damage:
		animated_sprite.play("attack")
	elif abs(enemy_controller.velocity.x) > 0.0:
		animated_sprite.play("walk")
	else: 
		animated_sprite.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
