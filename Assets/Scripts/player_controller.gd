class_name PlayerController extends CharacterBody2D

@export var speed = 7.0
@export var jump_power = 8.0

var speed_multiplier = 30.0
var jump_multiplier = -30.0
var direction = 0

@export var inventory: Inventory
const nome = "player1"

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_power * jump_multiplier
		
	# Handle pickup item
	if Input.is_action_just_pressed("pickup_item"):pass
		#inventory.pickup_item()
		
	# Handle drop item (g)
	if Input.is_action_just_pressed("drop_item"):pass
		#inventory.drop_item()
		
	# Handle equip the primary weapon (1)
	if Input.is_action_just_pressed("primary_weapon"):
		inventory.select_current_item("primary")
		
	# Handle equip the secondary weapon (2)
	if Input.is_action_just_pressed("secondary_weapon"):
		inventory.select_current_item("secondary")
		
	# Handle equip the ability (3)
	if Input.is_action_just_pressed("ability"):
		inventory.select_current_item("ability")
	
	# Handle attack with weapon
	if Input.is_action_just_pressed("attack"):
		inventory.attack()
	

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
