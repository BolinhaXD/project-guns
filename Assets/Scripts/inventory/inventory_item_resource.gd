extends Resource

class_name InventoryItem

@export var name: String = "" 
@export var texture: Texture2D
@export var type: types
@export var shape2D: Shape2D
@export var shape2DRotation_degrees: float
@export var shape2DPosition: Vector2

@export var damage: float

enum types{
	PRIMARY,
	SECONDARY, 
	ABILITY
}
