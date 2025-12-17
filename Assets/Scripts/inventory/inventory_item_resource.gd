class_name InventoryItem extends Resource


@export var name: String = "" 
@export var animation_texture: Texture2D
@export var icon_texture: Texture2D
@export var in_hand_texture: Texture2D
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

func attack():pass
