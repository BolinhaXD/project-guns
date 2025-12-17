extends Node2D

@onready var inventory: Inventory = preload("res://Assets/Scripts/inventory/playerInventory.tres")
@onready var item_base_hand_scene = load("res://Assets/Scenes/item_hand.tscn")
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
	if _type == "none":
		if get_child(2) != null:
			get_child(2).queue_free()
			
	if inventory.current_selected_item != null:
		if get_child(2) != null:
			get_child(2).queue_free()
		
		var item_instance = item_base_hand_scene.instantiate()
		item_instance.player_controller = player_controller
		item_instance.raycast_2d = raycast_2d
		item_instance.hands_area = area
		item_instance.name = "current_weapon"
		item_instance.texture = inventory.current_selected_item.in_hand_texture
		add_child(item_instance)
		print(get_children())
