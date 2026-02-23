## Base resource of the items 
## Its used to have a base of what the items need to be items
class_name InventoryItem extends Resource

## Name of the item
@export var name: String = "" 

## Texture when the item is on the ground
@export var animation_texture: Texture2D

## Texture when the item is on the inventory
@export var icon_texture: Texture2D

## Texture when the item is in hand
@export var in_hand_texture: Texture2D

## Type of the item: primary, secondary or an ability (still in thinking process)
@export var type: types

## Offset where the item is supposed to be (to be reformed)
@export var sprite_in_hand_position: Vector2

## Damage of the item
@export var damage: float

## Signal that emits when the player attacks
signal item_attack

## Existing types
enum types{
	PRIMARY,
	SECONDARY, 
	ABILITY
}

## Attack function, called when a player attack (presses right-click)
func attack():
	item_attack.emit()
	pass

## Hash function to make every item unique (probably not needed)
func get_hash():
	return hash(name) + hash(animation_texture) + hash(type)
