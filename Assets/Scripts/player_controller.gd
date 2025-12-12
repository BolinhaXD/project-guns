class_name PlayerController extends CharacterBody2D

@export var speed = 7.0
@export var jump_power = 8.0

var speed_multiplier = 30.0
var jump_multiplier = -30.0
var direction = 0

@export var inventory: Inventory


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_power * jump_multiplier
		
	# Handle pickup item
	if Input.is_action_just_pressed("pickup_item") and is_on_floor():pass
		#inventory.pickup_item()
		
	# Handle drop item
	if Input.is_action_just_pressed("drop_item") and is_on_floor():pass
		#inventory.drop_item()
		
	# Handle equip the primary weapon
	if Input.is_action_just_pressed("primary_weapon") and is_on_floor():pass
		
		
	# Handle equip the secondary weapon
	if Input.is_action_just_pressed("secondary_weapon") and is_on_floor():pass
		
	# Handle use the ability
	if Input.is_action_just_pressed("ability") and is_on_floor():pass
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed * speed_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Item:
		area.get_parent().pickup(self)
