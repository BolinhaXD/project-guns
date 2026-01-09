class_name PlayerController extends CharacterBody2D

@export var speed: float = 7.0
@export var jump_power = 8.0
@export var health_points: float = 100.0

var speed_multiplier = 30.0
var jump_multiplier = -30.0
var direction = 0

@export var inventory: Inventory

signal picked_up
var possible_pickup_items: Array[Item]


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_power * jump_multiplier
		
	# Handle pickup item (E)
	if Input.is_action_just_pressed("pickup_item"):
		if !possible_pickup_items.is_empty():
			picked_up.emit()
			inventory.pickup_item(possible_pickup_items[0].item_info)
		
	# Handle drop item (G)
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
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed * speed_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)
	move_and_slide()


func take_damage(_damage):
	if health_points > _damage:
		health_points -= _damage
	else:
		health_points = 0
		dead()
	print("Health: ", health_points)


func dead():
	pass


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
