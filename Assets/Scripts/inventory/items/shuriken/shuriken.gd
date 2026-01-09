extends ItemBaseHand

@onready var shuriken_projectile_scene = preload("res://Assets/Scenes/Items/shuriken/shuriken_projectile.tscn")
@onready var marker2d: Marker2D = $Marker2D


func item_attack():
	var shuriken_projectile_instance = shuriken_projectile_scene.instantiate()
	shuriken_projectile_instance.global_position = marker2d.global_position
	shuriken_projectile_instance.rotation_degrees = rotation_degrees
	get_tree().root.add_child(shuriken_projectile_instance)
