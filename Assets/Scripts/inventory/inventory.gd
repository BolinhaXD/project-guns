extends Resource

class_name Inventory

signal updated

@export var current_primary: InventoryItem
@export var current_secondary: InventoryItem
@export var current_ability: InventoryItem

@export var current_select_item: InventoryItem

func pickup_item(_inventoryItem: InventoryItem):
	match _inventoryItem.type:
		InventoryItem.types.PRIMARY:
			current_primary = _inventoryItem
			print(current_primary.name)
		InventoryItem.types.SECONDARY:
			current_secondary = _inventoryItem
			print(current_secondary.name)
		InventoryItem.types.ABILITY:
			current_ability = _inventoryItem
			print(current_ability.name)
	updated.emit()
	

func drop_item():
	pass
	
