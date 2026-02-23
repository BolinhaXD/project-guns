## Class responsible for what the player is holding
extends Node2D

## The inventory of the player 
@onready var inventory: Inventory = preload("res://Assets/Scripts/Resources/playerInventory.tres")

## The range of which the hands of the player can reach
@onready var area: Area2D = $Area2D

## Raycast that helps place the hands on the right range
@onready var raycast_2d: RayCast2D = $RayCast2D

## The Player
@export var player_controller: PlayerController

## Sprite the will make the weapons and hands appear in
@export var item_sprite: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update()
	inventory.selected_item_updated.connect(update)


func _physics_process(_delta: float) -> void:
	## Makes the raycast follow the mouse at all times
	raycast_2d.global_position = player_controller.get_global_mouse_position()
	raycast_2d.target_position = raycast_2d.to_local(area.global_position)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

## Function resposible for updating the hand sprite depending on what happened (got switch, dropped, pickep up)
func update(_type: String = "none"):
	if get_child(2) != null:
		get_child(2).queue_free()
		remove_child(get_child(2))
	
	# Has a weapon equipped
	if inventory.current_selected_item != null:
		
		# Create the item in hand
		var msg = "res://Assets/Scenes/Items/" + inventory.current_selected_item.name + "/" + inventory.current_selected_item.name + "_in_hand.tscn"
		var item_load = load(msg)
		print(msg)
		var item_instance = item_load.instantiate()
		item_instance.player_controller = player_controller
		item_instance.hands_area = area
		item_instance.raycast_2d = raycast_2d
		item_instance.item_resource = inventory.current_selected_item
		add_child(item_instance)
