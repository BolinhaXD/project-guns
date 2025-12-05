extends Resource

class_name Inventory

@export var current_weapon: InventoryItem
@export var current_secondary: InventoryItem
@export var current_ability: InventoryItem


func insert(_item: InventoryItem): pass
