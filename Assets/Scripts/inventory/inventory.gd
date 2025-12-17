extends Resource

class_name Inventory

signal hotbar_sprite_updated
signal selected_item_updated(type: String)

@export var current_primary: InventoryItem
@export var current_secondary: InventoryItem
@export var current_ability: InventoryItem

@export var current_selected_item: InventoryItem

func pickup_item(_inventoryItem: InventoryItem):
	match _inventoryItem.type:
		InventoryItem.types.PRIMARY:
			current_primary = _inventoryItem
		InventoryItem.types.SECONDARY:
			current_secondary = _inventoryItem
		InventoryItem.types.ABILITY:
			current_ability = _inventoryItem
	hotbar_sprite_updated.emit()
	

func drop_item():
	#instanciate()
	pass
	
	
func select_current_item(_itemTypeName: String):
	match _itemTypeName:
		"primary":
			if current_selected_item == null :
				current_selected_item = current_primary
				selected_item_updated.emit("primary")
			elif current_selected_item.type == InventoryItem.types.PRIMARY:
				current_selected_item = null
				selected_item_updated.emit("none")
			else:
				current_selected_item = current_primary
				selected_item_updated.emit("primary")
		"secondary":
			if current_selected_item == null:
				current_selected_item = current_secondary
				selected_item_updated.emit("secondary")
			elif current_selected_item.type == InventoryItem.types.SECONDARY:
				current_selected_item = null
				selected_item_updated.emit("none")
			else:
				current_selected_item = current_secondary
				selected_item_updated.emit("secondary")
		"ability":
			if current_selected_item == null :
				current_selected_item = current_ability
				selected_item_updated.emit("ability")
			elif current_selected_item.type == InventoryItem.types.ABILITY:
				current_selected_item = null
				selected_item_updated.emit("none")
			else:
				current_selected_item = current_ability
				selected_item_updated.emit("ability")
		_:
			print("No item")
			
	if  current_selected_item == null:
		print("No item!")
	
