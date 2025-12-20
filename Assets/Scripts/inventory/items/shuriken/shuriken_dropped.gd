extends Item


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	item_info = ItemDataBase.get_item("shuriken").duplicate()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
