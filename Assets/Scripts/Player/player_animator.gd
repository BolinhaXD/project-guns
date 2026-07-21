## Class responsible for the animation of the animation of the player
extends Node2D

@export var player_controller : PlayerController
@export var animation_player : AnimationPlayer
@export var sprite: Sprite2D

var current_place

func _process(_delta):
	## Direction of the player
	if player_controller.direction == 1:
		sprite.flip_h = false
	elif player_controller.direction == -1:
		sprite.flip_h = true
	
	## Moving or idle animations
	if player_controller.is_on_floor_only():
		current_place = "chao"
		if abs(player_controller.velocity.x) > 0.0:
			animation_player.play("move")
		else: 
			animation_player.play("idle")
			
	## Sliding animations
	if player_controller.is_on_wall():
		current_place = "wall"
		if player_controller.direction == 1:
			sprite.flip_h = true
		elif player_controller.direction == -1:
			sprite.flip_h = false
		animation_player.play("sliding")
	
	## Jumping or falling animations
	if !player_controller.is_on_floor() and !player_controller.is_on_ceiling() and !player_controller.is_on_wall():
		current_place = "ar"
		if player_controller.velocity.y < 0.0:
			animation_player.play("jump")
		elif player_controller.velocity.y > 0.0:
			animation_player.play("fall")
	
