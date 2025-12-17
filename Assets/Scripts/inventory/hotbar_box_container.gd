extends BoxContainer

@onready var inventory: Inventory = preload("res://Assets/Scripts/inventory/playerInventory.tres")
@onready var current_weapon_seconday_ability: Array = get_children()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update()
	inventory.hotbar_sprite_updated.connect(update)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func update():
	current_weapon_seconday_ability[0].update(inventory.current_primary)
	current_weapon_seconday_ability[1].update(inventory.current_secondary)
	current_weapon_seconday_ability[2].update(inventory.current_ability)
	pass
