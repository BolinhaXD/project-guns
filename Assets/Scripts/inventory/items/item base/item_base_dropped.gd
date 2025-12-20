class_name Item extends Sprite2D

@export var item_info: Resource

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
	
func pickup(player: PlayerController):
	player.inventory.pickup_item(item_info)
	queue_free()
