class_name Item extends Sprite2D

@export var item_info: Resource


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture = item_info.icon_texture
	var collisionShape2D = $Area2D/CollisionShape2D
	collisionShape2D.shape = item_info.shape2D
	collisionShape2D.rotation_degrees = item_info.shape2DRotation_degrees
	collisionShape2D.position = item_info.shape2DPosition
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
	
func pickup(player: PlayerController):
	player.inventory.pickup_item(item_info.duplicate())
	queue_free()
	pass
