## Responsible for the inventory of the player 
## It can drop, pick up items 
extends Resource
class_name Inventory

## Signal to make the hotbar update
signal hotbar_sprite_updated

## Signal to make the slot update
signal selected_item_updated(type: String)

## Signal for the player to drop an item (because the inventory is not a scene, it cannot spawn items)
signal item_dropped(type: Node2D)

@export var current_primary: InventoryItem
@export var current_secondary: InventoryItem
@export var current_ability: InventoryItem

@export var current_selected_item: InventoryItem


func pickup_item(_inventoryItem: InventoryItem = null):
	match _inventoryItem.type:
		InventoryItem.types.PRIMARY:
			if current_primary != null:
				item_dropped.emit(instanciate_inventory_item(InventoryItem.types.PRIMARY))
				drop_item(current_primary)
			current_primary = _inventoryItem
		InventoryItem.types.SECONDARY:
			if current_secondary != null:
				item_dropped.emit(instanciate_inventory_item(InventoryItem.types.SECONDARY))
				drop_item(current_secondary)
			current_secondary = _inventoryItem
		InventoryItem.types.ABILITY:
			if current_ability != null:
				item_dropped.emit(instanciate_inventory_item(InventoryItem.types.ABILITY))
				drop_item(current_ability)
			current_ability = _inventoryItem
	hotbar_sprite_updated.emit()


func drop_item(_item_info: InventoryItem = null):
	if _item_info == current_selected_item:
		current_selected_item = null
		selected_item_updated.emit("none")
	match _item_info.type:
		InventoryItem.types.PRIMARY:
			current_primary = null
		InventoryItem.types.SECONDARY:
			current_secondary = null
		InventoryItem.types.ABILITY:
			current_ability = null
	hotbar_sprite_updated.emit()


func instanciate_inventory_item(_type: InventoryItem.types):
	var msg
	var item_instance
	match _type:
		InventoryItem.types.PRIMARY:
			msg = "res://Assets/Scenes/Items/" + current_primary.name + "/" + current_primary.name + "_dropped.tscn"
			item_instance = load(msg).instantiate()
			item_instance.item_info = current_primary
		InventoryItem.types.SECONDARY:
			msg = "res://Assets/Scenes/Items/" + current_secondary.name + "/" + current_secondary.name + "_dropped.tscn"
			item_instance = load(msg).instantiate()
			item_instance.item_info = current_secondary
		InventoryItem.types.ABILITY:
			msg = "res://Assets/Scenes/Items/" + current_ability.name + "/" + current_ability.name + "_dropped.tscn"
			item_instance = load(msg).instantiate()
			item_instance.item_info = current_ability
	item_instance.is_initialised = true
	return item_instance


func instanciate_current_selected_item():
	var msg = "res://Assets/Scenes/Items/" + current_selected_item.name + "/" + current_selected_item.name + "_dropped.tscn"
	var item_load = load(msg)
	var item_instance = item_load.instantiate()
	item_instance.item_info = current_selected_item
	item_instance.is_initialised = true
	return item_instance


func select_current_item(_itemTypeName: String):
	match _itemTypeName:
		"primary":
			if current_selected_item == null:
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
			if current_selected_item == null:
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
	

func attack():
	if current_selected_item != null:
		current_selected_item.attack()
