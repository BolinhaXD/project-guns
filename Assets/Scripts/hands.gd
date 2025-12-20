extends Node2D

@onready var inventory: Inventory = preload("res://Assets/Scripts/Resources/playerInventory.tres")
@onready var area: Area2D = $Area2D
@onready var raycast_2d: RayCast2D = $RayCast2D

@export var player_controller: PlayerController
@export var item_sprite: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update()
	inventory.selected_item_updated.connect(update)


func _physics_process(_delta: float) -> void:
	raycast_2d.global_position = player_controller.get_global_mouse_position()
	raycast_2d.target_position = raycast_2d.to_local(area.global_position)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func update(_type: String = "none"):
	if get_child(2) != null:
		get_child(2).queue_free()
		remove_child(get_child(2))
	
	# Has a weapon equipped
	if inventory.current_selected_item != null:
		
		# Create the item in hand
		var msg = "res://Assets/Scenes/Items/" + inventory.current_selected_item.name + "/" + inventory.current_selected_item.name + "_in_hand.tscn"
		var item_load = load(msg)
		var item_instance = item_load.instantiate()
		item_instance.player_controller = player_controller
		item_instance.raycast_2d = raycast_2d
		item_instance.hands_area = area
		item_instance.item_resource = inventory.current_selected_item
		add_child(item_instance)
