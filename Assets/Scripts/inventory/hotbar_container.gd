extends BoxContainer

@onready var inventory: Inventory = preload("res://Assets/Scripts/inventory/playerInventory.tres")
@onready var current_weapon: Array = get_children()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
