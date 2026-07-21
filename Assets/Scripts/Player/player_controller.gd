## Main class of the multiuple player that can exist
## This class is what the player uses to move and interact with the enviroment 
## Contains inventory systems and multiple possible actions such as droping shotting/attacking with the weapons
class_name PlayerController extends CharacterBody2D

## UI of the player
@onready var gui_scene = preload("res://Assets/Scenes/UI/gui.tscn")

## Speed which the player walks
@export var speed: float = 7.0

## The force applied to the player to be able to jump
@export var jump_power = 8.0

## Health of the player
@export var health_points: float = 100.0

## Multiplier applied to the movement
var speed_multiplier = 30.0

## Multiplier applied to the jump
var jump_multiplier = -30.0

## Multiplier applied to the jump
var wall_jump_multiplier = -20.0


## Direction of the player (-1: left, 1: right)
var direction = 0

## Control if the player can leap in a wall
var can_leap = true
var leap_count = 0

## Wall jump helpers
var wall_jump: Vector2 = Vector2.ZERO
var wall_jump_timer: float = 0.0 
var right_wall_jump_direction: Vector2 = Vector2(-1,-1)
var left_wall_jump_direction: Vector2 = Vector2(1,-1)
var was_on_wall_last_frame = false

## Inventory of the player (its own class)
@export var inventory: Inventory

## Signal when an item is picked up
signal picked_up

## Array that controls the items that are on the ground possible to be picked up
## Makes an ordering of what can be picked up first
var possible_pickup_items: Array[Item]

func _ready() -> void:
	inventory.item_dropped.connect(drop_item)
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	#if is_on_wall_only():
		#if leap_count == 0:
			#leap_count += 1
		#else:
			#leap_count == 0 
			#can_leap = false
	#
	if wall_jump_timer > 0.0:
		velocity = wall_jump
		wall_jump_timer -= delta
		if wall_jump_timer <= 0.0:
			wall_jump = Vector2.ZERO

	# Handle jump.
	## 
	if Input.is_action_just_pressed("jump"):
		if is_on_floor_only():
			velocity.y = jump_power * jump_multiplier * 1.5
		if is_on_wall_only() and can_leap:
			if get_wall_normal().x > 0:
				apply_wall_jump(left_wall_jump_direction, 0.24)
			else:
				apply_wall_jump(right_wall_jump_direction, 0.24) 
		
	# Handle pickup item (E)
	## Emits the signal and makes the inventory pick up the item
	if Input.is_action_just_pressed("pickup_item"):
		if !possible_pickup_items.is_empty():
			picked_up.emit()
			inventory.pickup_item(possible_pickup_items[0].item_info)
		
	# Handle drop item (G)
	## Removes the item from the inventory and creates it dropped (need refactor)
	if Input.is_action_just_pressed("drop_item"):
		if inventory.current_selected_item != null:
			var item_instance = inventory.instanciate_current_selected_item()
			item_instance.player_controller = self
			item_instance.global_position = get_node("Hands").global_position
			inventory.drop_item(item_instance.item_info)
			get_tree().root.add_child(item_instance)
		
	# Handle equip the primary weapon (1)
	if Input.is_action_just_pressed("primary_weapon"):
		inventory.select_current_item("primary")
		
	# Handle equip the secondary weapon (2)
	if Input.is_action_just_pressed("secondary_weapon"):
		inventory.select_current_item("secondary")
		
	# Handle equip the ability (3)
	if Input.is_action_just_pressed("ability"):
		inventory.select_current_item("ability")
	
	# Handle attack with weapon (right-click)
	if Input.is_action_just_pressed("attack"):
		inventory.attack()
	
	# Handle pause
	if Input.is_action_just_pressed("pause"):
		print("pause")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed * speed_multiplier
		if is_on_wall_only():
			if direction == normalized_wall(get_wall_normal()):
				velocity.y = velocity.y / 2
	else:
		velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)
	move_and_slide()


## Makes the player take damage from diferent sources
func take_damage(_damage):
	if health_points > _damage:
		health_points -= _damage
	else:
		health_points = 0
		dead()
	print("Health: ", health_points)

## Makes the player die (still in development)
func dead():
	pass

## Make the player drop the item if an item of the same type is picked up
func drop_item(item: Node2D):
	item.player_controller = self
	item.global_position = get_node("Hands").global_position
	get_tree().root.add_child(item)

## When the player enters an area 
## If the area is an item it makes the indication pop up and it will be able to be picked up
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Item:
		area.get_parent().get_node("Pickup").visible = true
		area.get_parent().player_controller = self
		
		if !possible_pickup_items.is_empty():
			if !possible_pickup_items.has(area.get_parent()):
				possible_pickup_items.append(area.get_parent())
		else:
			if !possible_pickup_items.has(area.get_parent()):
				possible_pickup_items.append(area.get_parent())
				area.get_parent().player_controller.picked_up.connect(area.get_parent().queue_free)

## When the player leaves an area 
## If the area is an item it makes so that the indication pop out and it will not be able to be picked up
func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is Item:
		area.get_parent().get_node("Pickup").visible = false
		
		if !possible_pickup_items.is_empty():
			if possible_pickup_items[0] == area.get_parent():
				possible_pickup_items.erase(area.get_parent())
				area.get_parent().player_controller.picked_up.disconnect(area.get_parent().queue_free)
				if !possible_pickup_items.is_empty():
					possible_pickup_items[0].player_controller.picked_up.connect(possible_pickup_items[0].queue_free)
			else:
				possible_pickup_items.erase(area.get_parent())

# Function to normalize the normal of the wall
func normalized_wall(normal: Vector2):
	if normal.x < 0:
		return 1.0
	else: return -1.0

func apply_wall_jump(direction_vec: Vector2, wall_jump_duration: float) -> void:
	wall_jump = direction_vec * jump_power * (-jump_multiplier) * 1.5
	wall_jump_timer = wall_jump_duration

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Ground"):
		if is_on_wall() and not is_on_floor() and not is_on_ceiling():
			was_on_wall_last_frame = true
			print("true")
		else:
			was_on_wall_last_frame = false
			print("false")
