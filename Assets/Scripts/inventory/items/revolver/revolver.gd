class_name Revolver extends ItemBaseHand

@onready var bullet_scene = preload("res://Assets/Scenes/Items/Revolver/bullet.tscn")
@onready var marker2d: Marker2D = $Marker2D

func item_attack():
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.global_position = marker2d.global_position
	bullet_instance.rotation_degrees = rotation_degrees
	get_tree().root.add_child(bullet_instance)
