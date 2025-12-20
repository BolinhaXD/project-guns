class_name InventoryItem extends Resource

@export var name: String = "" 
@export var animation_texture: Texture2D
@export var icon_texture: Texture2D
@export var in_hand_texture: Texture2D
@export var type: types
@export var sprite_in_hand_position: Vector2

@export var damage: float

signal item_attack

enum types{
	PRIMARY,
	SECONDARY, 
	ABILITY
}

func attack():
	item_attack.emit()
	pass
