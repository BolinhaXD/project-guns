class_name Revolver extends ItemBaseHand

@onready var bullet_scene = preload("res://Assets/Scenes/Items/Revolver/bullet.tscn")

func item_attack():
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.global_position = global_position
	bullet_instance.rotation = rad_to_deg(Vector2(5, 0).angle_to(hands_area.get_local_mouse_position()))
	get_tree().root.add_child(bullet_instance)
