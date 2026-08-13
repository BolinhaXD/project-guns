extends Control

@onready var inventory: Inventory = preload("res://Assets/Scripts/Resources/playerInventory.tres")
@onready var hotbar_sprite: Sprite2D = $Sprite2D
@onready var label: Label = $"../HealthBar/Label"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update()
	inventory.selected_item_updated.connect(update)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func update(type: String = "none"):
	match type:
		"none":
			hotbar_sprite.frame_coords.x = 0
		"primary":
			hotbar_sprite.frame_coords.x = 1
		"secondary":
			hotbar_sprite.frame_coords.x = 2
		"ability":
			hotbar_sprite.frame_coords.x = 3
