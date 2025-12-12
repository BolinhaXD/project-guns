extends Panel

@onready var item_texture_rect: TextureRect = $TextureRect

func update(_inventoryItem: InventoryItem):
	if !_inventoryItem:
		item_texture_rect.visible = false
	else:
		item_texture_rect.visible = true
		item_texture_rect.texture = _inventoryItem.icon_texture
