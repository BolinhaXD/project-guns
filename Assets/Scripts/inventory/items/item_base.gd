extends Sprite2D

@export var item_info: Resource

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture = item_info.texture
	var collisionShape2D = $Area2D/CollisionShape2D
	collisionShape2D.shape = item_info.shape2D
	collisionShape2D.rotation_degrees = item_info.shape2DRotation_degrees
	collisionShape2D.position = item_info.shape2DPosition
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group('Player'):
		queue_free()
